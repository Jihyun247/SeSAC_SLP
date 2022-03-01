//
//  ResultHttpViewModel.swift
//  SeSAC_SLP
//
//  Created by 김지현 on 2022/02/21.
//

import Foundation
import RxSwift
import RxCocoa

class ResultHttpViewModel {
    
    func deleteQueue() {
        APIService.shared.deleteQueue { result in
            
            switch result {
                
            case .success(_):
                print("delete success")
            case .tokenExpiration:
                self.deleteQueue()
            case .uncommon(let statusCode):
                print(statusCode)
            case .fail:
                print("fail")
            }
        }
    }
}
