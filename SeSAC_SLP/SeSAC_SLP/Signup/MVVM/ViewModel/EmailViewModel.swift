//
//  EmailViewModel.swift
//  SeSAC_SLP
//
//  Created by 김지현 on 2022/01/24.
//

import Foundation
import RxSwift
import RxCocoa

class EmailViewModel: ViewModel {
    
    var disposeBag = DisposeBag()
    
    struct Input {
        let email: ControlProperty<String?>
        let tap: ControlEvent<Void>
    }

    struct Output {
        let emailValidStatus: Observable<Bool>
        let sceneTransition: ControlEvent<Void>
    }
    
    func transform(input: Input) -> Output {

        let valid = input.email
            .orEmpty
            .distinctUntilChanged()
            .map { self.isValidEmail(email: $0) }
            .share(replay: 1, scope: .whileConnected)

        return Output(emailValidStatus: valid, sceneTransition: input.tap)
    }
    
    func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
}
