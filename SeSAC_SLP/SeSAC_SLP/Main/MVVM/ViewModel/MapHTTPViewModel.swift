//
//  MapHTTPViewModel.swift
//  SeSAC_SLP
//
//  Created by 김지현 on 2022/02/09.
//

import Foundation
import RxSwift
import RxCocoa
import Firebase
import FirebaseAuth
import AVFoundation

class MapHTTPViewModel {

    let exploreResult = PublishSubject<AroundQueue>()
    
    func onqueue(region: Int, lat: Double, long: Double) {
        APIService.shared.onqueue(region, lat, long) { result in
            switch result {
                
            case .success(let data):
                guard let exploreData = data else {
                    print("결과 없음")
                    return
                }
                //print(exploreData)
                self.exploreResult.onNext(exploreData)
            case .tokenExpiration:
                self.onqueue(region: region, lat: lat, long: long)
            case .uncommon(let statusCode):
                print(statusCode)
            case .fail:
                print("fail")
            }
        }
    }
}
