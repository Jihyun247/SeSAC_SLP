//
//  AuthViewModel.swift
//  SeSAC_SLP
//
//  Created by 김지현 on 2022/01/21.
//

import Foundation
import RxSwift
import RxCocoa
import Firebase
import FirebaseAuth

class AuthViewModel: ViewModel {
    
    var phoneNum = BehaviorRelay<String>(value: "")
    var valid = BehaviorRelay<Bool>(value: false)
    
    var disposeBag = DisposeBag()
    
    struct Input {
        var inputCode: ControlProperty<String?>
        let resendTap: ControlEvent<Void>
        let nextTap: ControlEvent<Void>
    }

    struct Output {
        let codeValidStatus: Observable<Bool>
        let resendVerifyCode: ControlEvent<Void>
        let verifyCodeStart: ControlEvent<Void>
    }
    
    func transform(input: Input) -> Output {

        let valid = input.inputCode
            .orEmpty
            .distinctUntilChanged()
            .map { $0.count == 6 }
            .share(replay: 1, scope: .whileConnected)
        
        valid
            .bind(to: self.valid)
            .disposed(by: disposeBag)
        
        return Output(codeValidStatus: valid, resendVerifyCode: input.resendTap ,verifyCodeStart: input.nextTap)
    }
}
