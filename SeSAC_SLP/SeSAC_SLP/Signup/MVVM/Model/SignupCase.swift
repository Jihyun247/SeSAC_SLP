//
//  SignupCase.swift
//  SeSAC_SLP
//
//  Created by 김지현 on 2022/01/31.
//

import Foundation

enum AuthResponse: String {
    case blocked = "We have blocked all requests from this device due to unusual activity. Try again later."
}

enum LoginResult {
    case member, notMember, fail
}

enum SignupResult {
    case success, alreadyUser, cantUseNickname, fail
}

enum Gender: Int {
    case woman = 0
    case man = 1
    case none = -1
}
