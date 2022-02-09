//
//  MapViewModel.swift
//  SeSAC_SLP
//
//  Created by 김지현 on 2022/02/07.
//

import Foundation
import RxSwift
import RxCocoa
import FirebaseAuth
import CoreLocation

class MapViewModel {
    
    let locationManager = CLLocationManager()
    let currentLocation = BehaviorRelay<CLLocationCoordinate2D>(value: CLLocationCoordinate2D(latitude: UserDefaults.lat, longitude: UserDefaults.long))
    
    let selectedGender = BehaviorRelay<GenderFilter>(value: .all)
    let matchingStatus = BehaviorRelay<MatchingStatus>(value: .general)
    
    var menAnnotation: [SesacAnnotation] = []
    var womenAnnotation: [SesacAnnotation] = []
    
    struct Input {
        let allTap: ControlEvent<Void>
        let womenTap: ControlEvent<Void>
        let menTap: ControlEvent<Void>
        let currentLocationTap: ControlEvent<Void>
        let floatingTap: ControlEvent<Void>
    }

    struct Output {
        let genderSelected: Observable<GenderFilter>
        let floatingButtonClicked: Observable<MatchingStatus>
    }

    var disposeBag = DisposeBag()

    func transform(input: Input) -> Output {
        
        let genderObservable = Observable.merge(
            input.allTap.map { GenderFilter.all },
            input.menTap.map { GenderFilter.men },
            input.womenTap.map { GenderFilter.women }
          )
        
        genderObservable
            .asDriver(onErrorJustReturn: .all)
            .drive(selectedGender)
            .disposed(by: disposeBag)
        
        //let genderObservable = Observable.of(input.allTap, input.womenTap, input.menTap).merge()
        
        input.currentLocationTap.subscribe { _ in
            self.getCurrentLocation()
        }
        .disposed(by: disposeBag)
        
        let floatingObservable = input.floatingTap.map {
            self.matchingStatus.value
        }


        return Output(genderSelected: genderObservable, floatingButtonClicked: floatingObservable)
    }
    
    func getCurrentLocation() {
        print("호출")
        self.locationManager.startUpdatingLocation()
        self.currentLocation.accept(self.locationManager.location?.coordinate ?? CLLocationCoordinate2D(latitude: UserDefaults.lat, longitude: UserDefaults.long))
        
        setLatLongRegion(coordinate: self.locationManager.location?.coordinate ?? self.currentLocation.value)
    }
    
    func setLatLongRegion(coordinate: CLLocationCoordinate2D) {
        UserDefaults.lat = 37.51818789942772
        UserDefaults.long = 126.88541765534976
        UserDefaults.region = 1275130688
//        UserDefaults.lat = coordinate.latitude.magnitude
//        UserDefaults.long = coordinate.longitude.magnitude
//        UserDefaults.region = .calculateRegion(lat: UserDefaults.lat, long: UserDefaults.long)
    }
}
