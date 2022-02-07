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

enum SendResult {
    case success, error, overAccess
}

class MapViewModel: ViewModel {
    
//    struct Input {
//        let phoneNum: ControlProperty<String?>
//    }
//
//    struct Output {
//        let numValidStatus: Observable<Bool>
//    }
//
//    var disposeBag = DisposeBag()
//
//    func transform(input: Input) -> Output {
//
//        let resultText = input.phoneNum
//            .orEmpty
//            .distinctUntilChanged()
//            .map { num -> Bool in
//                let phoneRegEx = "^01[0-1,6]-[0-9]{3,4}-[0-9]{4}$"
//                let pred = NSPredicate(format: "SELF MATCHES %@", phoneRegEx)
//                return pred.evaluate(with: num)
//            }
//            .share(replay: 1, scope: .whileConnected)
//
//        return Output(numValidStatus: resultText)
//    }
}
