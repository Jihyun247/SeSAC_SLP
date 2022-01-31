//
//  PhoneNumViewModel.swift
//  SeSAC_SLP
//
//  Created by 김지현 on 2022/01/21.
//

import Foundation
import RxSwift
import RxCocoa
import FirebaseAuth

enum SendResult {
    case success, error, overAccess
}

class PhoneNumViewModel: ViewModel {
    
    var verifyCode = BehaviorRelay<String>(value: "")
    
    struct Input {
        let phoneNum: ControlProperty<String?>
    }

    struct Output {
        let numValidStatus: Observable<Bool>
    }
    
    var disposeBag = DisposeBag()

    func transform(input: Input) -> Output {

        let resultText = input.phoneNum
            .orEmpty
            .distinctUntilChanged()
            .map { num -> Bool in
                let phoneRegEx = "^01[0-1,6]-[0-9]{3,4}-[0-9]{4}$"
                let pred = NSPredicate(format: "SELF MATCHES %@", phoneRegEx)
                return pred.evaluate(with: num)
            }
            .share(replay: 1, scope: .whileConnected)

        return Output(numValidStatus: resultText)
    }
    
    // Relay, Subject 는 Observable + Observer
    
    // Subject(Relay) 는 multicast 방식이기 때문에 여러개의 Observer를 subscribe 할 수 있다.
    // unicast? -> subscribed된 Observer가 Observable에 대해 독립적인 실행을 갖는 것
    
    // Observable은 단순 하나의 함수라고 생각하면 편함
    // Subject 및 Relay는 자주 변경되는 데이터 및 여러 옵저버에 의해 관찰당하는 데이터에 용이
}
