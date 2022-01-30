//
//  BirthViewModel.swift
//  SeSAC_SLP
//
//  Created by 김지현 on 2022/01/24.
//

import Foundation
import RxSwift
import RxCocoa

class BirthViewModel: ViewModel {
    
    var disposeBag = DisposeBag()
    
    var age = BehaviorRelay<Int>(value: 0)
    var valid = BehaviorRelay<Bool>(value: false)
    
    struct Input {
        let birthday: ControlProperty<Date> // birthday를 옵저버로 하니까
        let tap: ControlEvent<Void>
    }

    struct Output {
        let splitedBday: Observable<[String]>
        let ageValidStatus: Observable<Bool>
        let sceneTransition: ControlEvent<Void>
    }
    
    func transform(input: Input) -> Output {
        
        let splitedBday = input.birthday
            .map { $0.splitDate() }
            .share(replay: 1, scope: .whileConnected)
        
        input.birthday
            .map { $0.getAge() }
            .bind(to: age)
            .disposed(by: disposeBag)
        
        let valid = input.birthday
            .map { $0.getAge() >= 17 }
            .share(replay: 1, scope: .whileConnected)
        
        valid
            .bind(to: self.valid)
            .disposed(by: disposeBag)

        return Output(splitedBday: splitedBday, ageValidStatus: valid, sceneTransition: input.tap)
    }
}
