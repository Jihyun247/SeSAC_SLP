//
//  StartSearchViewModel.swift
//  SeSAC_SLP
//
//  Created by 김지현 on 2022/02/12.
//

import Foundation
import RxSwift
import RxCocoa

class StartSearchViewModel {
    
    let disposeBag = DisposeBag()
    
    let matchingStatus = PublishSubject<MatchingStatus>()
    
    let recommendHobby = BehaviorRelay<[String]>(value: [])
    let nearHobby = BehaviorRelay<[String]>(value: [])
    let othersHobby = BehaviorRelay<[String]>(value: [])
    
    struct Input {
        let aroundQueue: PublishSubject<AroundQueue>
        let tap: ControlEvent<Void>
    }

    struct Output {
        let recommendHobby: Observable<[String]>
        let nearHobby: Observable<[String]>
        let othersHobby: Observable<[String]>
        //let myHobby: Observable<[String]>
    }

    func transform(input: Input) -> Output {


        let recommendHobby =  input.aroundQueue.map { $0.fromRecommend }
        recommendHobby.bind(to: self.recommendHobby).disposed(by: disposeBag)
        
        let nearHobby =  input.aroundQueue.map { $0.fromQueueDB.map { $0.hf }.flatMap { $0 } }
        nearHobby.bind(to: self.nearHobby).disposed(by: disposeBag)
        // [[string]] -> [string]
        
        let othersHobby = Observable.combineLatest(recommendHobby, nearHobby) { $0 + $1 }
        othersHobby.bind(to: self.othersHobby).disposed(by: disposeBag)

        return Output(recommendHobby: recommendHobby, nearHobby: nearHobby, othersHobby: othersHobby)
    }
}
