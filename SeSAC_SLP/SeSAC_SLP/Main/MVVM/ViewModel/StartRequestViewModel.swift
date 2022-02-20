//
//  StartRequestViewModel.swift
//  SeSAC_SLP
//
//  Created by 김지현 on 2022/02/12.
//

import Foundation
import RxSwift
import RxCocoa

class StartRequestViewModel {
    
    let disposeBag = DisposeBag()
    
    let matchingStatus = PublishSubject<MatchingStatus>()
    
    let recommendHobby = BehaviorRelay<[String]>(value: [])
    let nearHobby = BehaviorRelay<[String]>(value: [])
    let othersHobby = BehaviorRelay<[String]>(value: [])
    
    var myHobbyArray: [String] = []
    let myHobby = BehaviorRelay<[String]>(value: [])
    
    var valid = BehaviorRelay<Bool>(value: false)
    
    struct Input {
        let aroundQueue: PublishSubject<AroundQueue>
        let myHobbyText: ControlProperty<String?>
        let returnTap: ControlEvent<Void>
        let startSearchTap: ControlEvent<Void>
    }

    struct Output {
        let recommendHobby: Observable<[String]>
        let nearHobby: Observable<[String]>
        let othersHobby: Observable<[String]>
        //let myHobby: Observable<[String]>
        let myHobbyLengthValid: Observable<Bool>
        let returnTapped: ControlEvent<Void>
        let startSearchTapped: ControlEvent<Void>
    }

    func transform(input: Input) -> Output {

        let recommendHobby =  input.aroundQueue.map { $0.fromRecommend }
        recommendHobby.bind(to: self.recommendHobby).disposed(by: disposeBag)
        
        let nearHobby =  input.aroundQueue.map { $0.fromQueueDB.map { $0.hf }.flatMap { $0 } }
        nearHobby.bind(to: self.nearHobby).disposed(by: disposeBag)
        // [[string]] -> [string]
        
        let othersHobby = Observable.combineLatest(recommendHobby, nearHobby) { $0 + $1 }
        othersHobby.bind(to: self.othersHobby).disposed(by: disposeBag)
        
        let myHobby = input.myHobbyText
            .orEmpty
            .distinctUntilChanged()
            .map { hobbyString -> [String] in
                print(hobbyString)
                let hobbyArray = hobbyString.components(separatedBy: " ")
                return hobbyArray
            }
            .share(replay: 1, scope: .whileConnected)
        
        let valid = myHobby
            .map { myHobbyArray -> Bool in

                let lastHobby = myHobbyArray.last ?? ""
                let condition: Bool = lastHobby.count <= 8 && lastHobby.count > 0
                
                return condition
            }
            .share(replay: 1, scope: .whileConnected)
        valid.bind(to: self.valid).disposed(by: disposeBag)


        return Output(recommendHobby: recommendHobby, nearHobby: nearHobby, othersHobby: othersHobby, myHobbyLengthValid: valid, returnTapped: input.returnTap, startSearchTapped: input.startSearchTap)
    }
    
    func addMyHobbyArray(string: String) {
        
        myHobbyArray.append(contentsOf: string.components(separatedBy: " ").filter {
            !myHobbyArray.contains($0)
        })
        myHobby.accept(self.myHobbyArray)
    }
    
    func deleteMyHobbyArray(index: Int) {
        
        myHobbyArray.remove(at: index)
        myHobby.accept(self.myHobbyArray)
    }
}
