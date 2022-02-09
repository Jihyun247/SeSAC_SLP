//
//  NetworkResult.swift
//  SeSAC_SLP
//
//  Created by 김지현 on 2022/01/23.
//

import Foundation

enum NetworkResult<T> {
    case success(T?)
    case uncommon(Int)
    case tokenExpiration
    case fail
}
