//
//  Protocols.swift
//  SeSAC_SLP
//
//  Created by 김지현 on 2022/01/23.
//

import Foundation
import RxSwift


protocol ViewModel {
    associatedtype Input
    associatedtype Output
    
    var disposeBag: DisposeBag {get set}
    
    func transform(input: Input) -> Output
}
