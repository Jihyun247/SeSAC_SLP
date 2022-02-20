//
//  StartSearchHTTPViewModel.swift
//  SeSAC_SLP
//
//  Created by 김지현 on 2022/02/19.
//

import Foundation
import RxSwift
import RxCocoa
import Firebase
import FirebaseAuth

class QueueHTTPViewModel {
    
    let queueResult = PublishSubject<Int>()
    
    func queue(region: Int, lat: Double, long: Double, hf: [String]) {
        APIService.shared.queue(region, lat, long, hf: hf) { result in
            switch result {
                
            case .success(_):
                self.queueResult.onNext(HTTPStatusCode.OK.rawValue)
            case .tokenExpiration:
                self.queue(region: region, lat: lat, long: long, hf: hf)
            case .uncommon(let statusCode):
                self.queueResult.onNext(statusCode)
            case .fail:
                print("fail")
            }
        }
    }
}
