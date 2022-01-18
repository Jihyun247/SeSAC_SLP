//
//  APIService.swift
//  SeSAC_SLP
//
//  Created by 김지현 on 2022/01/18.
//

import Foundation
import Moya

struct APIService {
    
    static let shared = APIService()
    let provider = MoyaProvider<APITarget>()
    
    
}
