//
//  StartSearchViewModel.swift
//  SeSAC_SLP
//
//  Created by 김지현 on 2022/02/12.
//

import Foundation
import RxSwift
import RxCocoa

class StartSearchViewModel: ViewModel {
    
    let aroundQueue = PublishSubject<AroundQueue>()
    let matchingStatus = PublishSubject<MatchingStatus>()
    
    struct Input {
        let hobbyText: ControlProperty<String?>
        //let othersHobbyTap: ControlEvent<Void>
        //let deleteMyHobbyTap: ControlEvent<Void>
    }

    struct Output {
        let recommendHobby: Observable<[String]>
        let nearHobby: Observable<[String]>
        //let addHobbyAction: ControlEvent<Void>
        //let deleteHobbyAction: ControlEvent<Void>
    }

    var disposeBag = DisposeBag()

    func transform(input: Input) -> Output {
        
        let recommendHobby = self.aroundQueue.map { $0.fromRecommend }
        let nearHobby = self.aroundQueue.map { $0.fromQueueDB.map { $0.hf } }
        // [[string]] -> [string]

        return Output(recommendHobby: recommendHobby, nearHobby: nearHobby)
    }
    
    
    
}
