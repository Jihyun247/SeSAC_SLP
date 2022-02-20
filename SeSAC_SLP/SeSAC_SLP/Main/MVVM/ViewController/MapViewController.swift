//
//  MainMapViewController.swift
//  SeSAC_SLP
//
//  Created by 김지현 on 2022/01/26.
//

import UIKit
import RxSwift
import RxCocoa
import CoreLocation
import MapKit

class MapViewController: UIViewController {
    
    // MARK: - 인스턴스
    let mainView = MapView(status: .general)
    let viewModel = MapViewModel()
    let httpViewModel = OnQueueHTTPViewModel()
    
    let disposeBag = DisposeBag()
    
    // MARK: - loadView()
    override func loadView() {
        self.view = mainView
    }
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "홈"
        navigationController?.initializeNavigationBarWithoutBackButton(navigationItem: self.navigationItem)
        binding()
        mapSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //viewModel.getCurrentLocation()
        httpViewModel.onqueue(region: UserDefaults.region, lat: UserDefaults.lat, long: UserDefaults.long)
    }
    
    // MARK: - binding
    func binding() {
        
        // MARK: - viewModel binding
        
        let input = MapViewModel.Input(allTap: mainView.allGenderButton.rx.tap, womenTap: mainView.womenGenderButton.rx.tap, menTap: mainView.menGenderButton.rx.tap, currentLocationTap: mainView.currentLocationButton.rx.tap, floatingTap: mainView.floatingButton.rx.tap)
        let output = viewModel.transform(input: input)
        
        viewModel.currentLocation.subscribe { location in
            self.mainView.mapView.setRegion(MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)), animated: true)
        }
        .disposed(by: disposeBag)

        output.genderSelected.subscribe { selectedGender in
            
            [self.mainView.allGenderButton, self.mainView.menGenderButton, self.mainView.womenGenderButton].forEach {
                $0.inactive()
                $0.layer.borderWidth = 0
            }
            switch selectedGender.element {
            case .all:
                self.mainView.allGenderButton.fill()
            case .men:
                self.mainView.menGenderButton.fill()
            case .women:
                self.mainView.womenGenderButton.fill()
            case .none:
                print("none")
            }
            
            self.httpViewModel.onqueue(region: UserDefaults.region, lat: UserDefaults.lat, long: UserDefaults.long)
        }
        .disposed(by: disposeBag)
        
        output.floatingButtonClicked.subscribe { matchingStatus in
            switch matchingStatus.element {
            case .general:
                if UserDefaults.gender == Gender.none.rawValue {
                    self.alert(title: "성별 설정으로 이동", message: "새싹 찾기 기능을 이용하기 위해서는 성별이 필요해요!") { action in
                        self.tabBarController?.selectedIndex = 3
                        let selectedNVC = self.tabBarController?.selectedViewController as? UINavigationController
                        selectedNVC?.pushViewController(MyProfileViewController(), animated: true)
                    }
                } else {
                    let vc = StartRequestViewController()
                    vc.viewModel.matchingStatus.onNext(self.viewModel.matchingStatus.value)
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            case .waiting:
                self.navigationController?.pushViewController(ResultRequestViewController(), animated: true)
            case .matched:
                self.navigationController?.pushViewController(ChatViewController(), animated: true)
            case .none:
                print("none")
            }
        }
        .disposed(by: disposeBag)

        // MARK: - httpViewModel binding
        
        httpViewModel.exploreResult.subscribe { queueResult in
            guard let result = queueResult.element else {
                self.alert(title: "에러가 발생했습니다", message: "다시 실행해주세요")
                return
            }
            self.viewModel.menAnnotation.removeAll()
            self.viewModel.womenAnnotation.removeAll()
            for aroundUser in (result.fromQueueDB + result.fromQueueDBRequested) {
                
                let coordinate = CLLocationCoordinate2D(latitude: aroundUser.lat, longitude: aroundUser.long)
                let sesacType = SesacType(rawValue: aroundUser.sesac)!
                let sesacAnnotation = SesacAnnotation(coordinate: coordinate, sesacType: sesacType)
                
                aroundUser.gender == Gender.man.rawValue ?
                    self.viewModel.menAnnotation.append(sesacAnnotation) :
                    self.viewModel.womenAnnotation.append(sesacAnnotation)
            }
            self.addFilteredAnnotations(gender: self.viewModel.selectedGender.value)
        }
        .disposed(by: disposeBag)

    }
    
    // MARK: - map setting
    func mapSetup() {
        mainView.mapView.delegate = self
        
        viewModel.locationManager.delegate = self
        viewModel.locationManager.requestWhenInUseAuthorization() // 권한 요청
    }
    
    // MARK: - Add Map Annotation
    // 여기서 추가된 어노테이션은 mkmapviewdelegate annotation 메서드를 통해 커스텀 되어 띄워지게 됨
    func addFilteredAnnotations(gender: GenderFilter){ // rxswift로 리팩토링

        mainView.mapView.removeAnnotations(mainView.mapView.annotations)
            
        switch gender {
        case .all:
            mainView.mapView.addAnnotations(viewModel.menAnnotation)
            mainView.mapView.addAnnotations(viewModel.womenAnnotation)
        case .men:
            mainView.mapView.addAnnotations(viewModel.menAnnotation)
        case .women:
            mainView.mapView.addAnnotations(viewModel.womenAnnotation)
        }
    }
}

// MARK: - MKMapViewDelegate (Annotation Custom & Map or User When Moved)
extension MapViewController: MKMapViewDelegate {
    
    // 재사용 할 수 있는 어노테이션 like tableview cell
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard let annotation = annotation as? SesacAnnotation else {
            return nil
        }

        var annotationView = mainView.mapView.dequeueReusableAnnotationView(withIdentifier: SesacAnnotationView.identifier)
        
        if annotationView == nil {

            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: SesacAnnotationView.identifier)
            annotationView?.canShowCallout = false
            
        } else {
            annotationView?.annotation = annotation
        }
        
        let image: UIImage?
        switch annotation.sesacType {
            
        case .basic:
            image = UIImage(named: "sesac_face_1")
        case .teunteun:
            image = UIImage(named: "sesac_face_2")
        case .mint:
            image = UIImage(named: "sesac_face_3")
        case .purple:
            image = UIImage(named: "sesac_face_4")
        case .gold:
            image = UIImage(named: "sesac_face_5")
        }
        annotationView?.image = image
        
        return annotationView
    }
    
    // 맵 이동
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        print("regionDidChangeAnimated \(UserDefaults.region)")
        
        viewModel.setLatLongRegion(coordinate: mapView.centerCoordinate)
        httpViewModel.onqueue(region: UserDefaults.region, lat: UserDefaults.lat, long: UserDefaults.long)
    }
    
    // 사용자 이동
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("didUpdateLocations \(UserDefaults.region)")
        viewModel.getCurrentLocation()
    }
}

// MARK: - CLLocationManagerDelegate (Location Authorization & Location Accuracy ..)

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        // 1. 권한이 바뀌었는지 체크해주는 delegate 함수를 통해 user의 위치 권한을 확인
        checkUserLocationServicesAuthorization(manager: manager)
    }
    
    func checkUserLocationServicesAuthorization(manager: CLLocationManager) {
        // 2. 위치 정확도 set & 3. 위치 권한 status 받아와서 checkCurrentLocationAuthorization 호출
        let authorizationStatus: CLAuthorizationStatus
        if #available(iOS 14, *) {
            authorizationStatus = manager.authorizationStatus
        } else {
            authorizationStatus = CLLocationManager.authorizationStatus()
        }
        
        setLocationAccuracy(manager)
        checkCurrentLocationAuthorization(authorizationStatus)
    }
    
    func checkCurrentLocationAuthorization(_ status: CLAuthorizationStatus) {
        // 4. 받아온 status에 따라 분기처리
        if CLLocationManager.locationServicesEnabled() {
            // 5. 위치 사용 가능하다면 현재위치 받아오기
            switch status { // CLAuthorizationStatus 분기처리
            case .notDetermined:
                viewModel.locationManager.requestWhenInUseAuthorization()
                viewModel.locationManager.startUpdatingLocation()
            case .restricted:
                print("restricted")
                alertLocationAuthorization()
            case .denied:
                print("restricted")
                alertLocationAuthorization()
            case .authorizedAlways, .authorizedWhenInUse:
//                viewModel.getCurrentLocation()
                httpViewModel.onqueue(region: UserDefaults.region, lat: UserDefaults.lat, long: UserDefaults.long)
            @unknown default:
                print("unknown")
            }
        }
    }
    
    func setLocationAccuracy(_ manager: CLLocationManager) {
        
        if #available(iOS 14.0, *) { // 위치 정확도
            let accuracyState = manager.accuracyAuthorization
            switch accuracyState {
            case .fullAccuracy:
                print("full")
            case .reducedAccuracy:
                print("reduced")
            @unknown default:
                print("Unknown")
            }
        }
    }
    
    func alertLocationAuthorization() {
        
        self.alert(title: "위치권한 요청", message: "새싹프렌즈 이용을 위해 위치 권한이 필요합니다", okTitle: "설정", cancelTitle: "취소", okHandler: { action in
            guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
            // 열 수 있는 url 이라면, 이동
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        })
    }
    
}
