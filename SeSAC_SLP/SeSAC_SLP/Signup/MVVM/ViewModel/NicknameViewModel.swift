//
//  NicknameViewModel.swift
//  SeSAC_SLP
//
//  Created by 김지현 on 2022/01/23.
//

import Foundation
import RxSwift
import RxCocoa

// Input Output 구조 적용

class NicknameViewModel: ViewModel {
    
    var disposeBag = DisposeBag()
    
    struct Input {
        let nickname: ControlProperty<String?>
        let tap: ControlEvent<Void>
    }

    struct Output {
        let nickValidStatus: Observable<Bool>
        let sceneTransition: ControlEvent<Void>
    }
    
    func transform(input: Input) -> Output {

        let valid = input.nickname
            .orEmpty
            .distinctUntilChanged()
            .map { $0.count < 10 && $0.count > 0 }
            .share(replay: 1, scope: .whileConnected)

        return Output(nickValidStatus: valid, sceneTransition: input.tap)
    }
}
