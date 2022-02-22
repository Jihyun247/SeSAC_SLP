//
//  ResultSesacViewModel.swift
//  SeSAC_SLP
//
//  Created by 김지현 on 2022/02/21.
//

import Foundation
import RxSwift
import RxCocoa

class ResultSesacViewModel {
    
    let disposeBag = DisposeBag()
    
    struct Input {
        let aroundQueue: PublishSubject<AroundQueue>
    }

    struct Output {
        let nearSesac: Observable<[AroundUser]>
    }

    func transform(input: Input) -> Output {
        
        let nearSesac = input.aroundQueue.map { $0.fromQueueDB }
        
        return Output(nearSesac: nearSesac)
    }
}
