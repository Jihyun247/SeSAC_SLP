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
    let currentLocation = BehaviorRelay<CLLocationCoordinate2D>(value: CLLocationCoordinate2D(latitude: 37.51818789942772, longitude: 126.88541765534976))
    
    struct Input {
        
    }

    struct Output {
        
    }

    var disposeBag = DisposeBag()

//    func transform(input: Input) -> Output {
//
//    }
}
