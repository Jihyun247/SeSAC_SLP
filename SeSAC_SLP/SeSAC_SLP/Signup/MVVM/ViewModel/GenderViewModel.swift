//
//  GenderViewModel.swift
//  SeSAC_SLP
//
//  Created by 김지현 on 2022/01/24.
//

import Foundation
import RxSwift
import RxCocoa

class GenderViewModel: ViewModel {
    
    var disposeBag = DisposeBag()
    
    private var isWomanSelected = BehaviorRelay<Bool>(value: false)
    private var isManSelected = BehaviorRelay<Bool>(value: false)
    
    struct Input {
        let womanTap: ControlEvent<Void>
        let manTap: ControlEvent<Void>
        let nextTap: ControlEvent<Void>
    }

    struct Output {
        let isWomanSelected: Observable<Bool> // 화면에서 제어
        let isManSelected: Observable<Bool>
        let leastOneSelected: Observable<Bool>
        let gender: Observable<Gender>
        let sceneTransition: ControlEvent<Void>
    }
    
    func transform(input: Input) -> Output {
        
        input.womanTap
            .subscribe { _ in
                if self.isWomanSelected.value == false && self.isManSelected.value == false {
                    // 아무것도 선택되어있지 않을 때
                    self.isWomanSelected.accept(true)
                } else {
                    self.isWomanSelected.value ? self.isWomanSelected.accept(false) : self.isWomanSelected.accept(true)
                }
                self.isManSelected.accept(false)
            }
            .disposed(by: disposeBag)
        
        input.manTap
            .subscribe { _ in
                if self.isWomanSelected.value == false && self.isManSelected.value == false {
                    // 아무것도 선택되어있지 않을 때
                    self.isManSelected.accept(true)
                } else {
                    self.isManSelected.value ? self.isManSelected.accept(false) : self.isManSelected.accept(true)
                }
                self.isWomanSelected.accept(false)
            }
            .disposed(by: disposeBag)
        
        let leastOne = Observable.combineLatest(isWomanSelected, isManSelected)
            .map { (womanSelected, manSelected) in
                return womanSelected || manSelected
            }
        
        let gender = Observable.combineLatest(isWomanSelected, isManSelected)
            .map { (womanSelected, manSelected) -> Gender in
                
                if womanSelected {
                    return Gender.woman
                } else if manSelected {
                    return Gender.man
                } else {
                    return Gender.none
                }
            }
            .share(replay: 1, scope: .whileConnected)

        return Output(isWomanSelected: isWomanSelected.asObservable(), isManSelected: isManSelected.asObservable(), leastOneSelected: leastOne, gender: gender, sceneTransition: input.nextTap)
    }
}
