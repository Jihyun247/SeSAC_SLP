//
//  MainMapViewController.swift
//  SeSAC_SLP
//
//  Created by 김지현 on 2022/01/26.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import CoreLocation
import MapKit

class MapViewController: UIViewController {
    
    // MARK: - 인스턴스
    let mainView = MapView(status: .general)
    let viewModel = MapViewModel()
    
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
    
    // MARK: - 바인딩 (Tap , Button)
    func binding() {
        
        viewModel.currentLocation.subscribe { location in
            self.mainView.mapView.setRegion(MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)), animated: true)
        }
        .disposed(by: disposeBag)

        
    }
    
    // MARK: - map setting
    func mapSetup() {
        mainView.mapView.delegate = self
        
        viewModel.locationManager.delegate = self
        viewModel.locationManager.requestWhenInUseAuthorization() // 권한 요청
    }
}

extension MapViewController: MKMapViewDelegate {
    
    // 재사용 할 수 있는 어노테이션 like tableview cell
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//
//    }
    
}

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
                alertLocationAuthorization()
                // 위치 권한 허용 팝업
            case .authorizedAlways, .authorizedWhenInUse:
                viewModel.locationManager.startUpdatingLocation()
                viewModel.currentLocation.accept(viewModel.locationManager.location!.coordinate)
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
        
        let alert = UIAlertController(title: "위치권한 요청", message: "새싹프렌즈 이용을 위해 위치 권한이 필요합니다", preferredStyle: .alert)
        let settingAction = UIAlertAction(title: "설정", style: .default) { action in
            guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
            // 열 수 있는 url 이라면, 이동
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel) { UIAlertAction in
            
        }
        
        alert.addAction(settingAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
}
