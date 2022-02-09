//
//  HTTPStatusCode.swift
//  SeSAC_SLP
//
//  Created by 김지현 on 2022/01/25.
//

import Foundation

enum HTTPStatusCode: Int {
    case OK = 200
    case FIREBASE_TOKEN_ERROR = 401
    case UNSUBSCRIBED_USER = 406
    case SERVER_ERROR = 500
    case CLIENT_ERROR = 501
}

// 회원가입
enum SignupStatusCode: Int {
    case ALREADY_SIGNIN = 201
    case CANT_USE_NICKNAME = 202
}

// 취미 함께할 친구 찾기 요청 (post queue)
enum QueueStatusCode: Int {
    case ALREADY_THREE_REPORT = 201
    case FIRST_PENALTY = 203
    case SECOND_PENALTY = 204
    case THIRD_PENALTY = 205
    case GENDER_NOT_SET = 206
}

// 취미 함께할 친구 찾기 중단 (delete queue) (공통 코드만 존재)

// 주변 새싹 탐색 기능 (post onqueue) (공통 코드만 존재)
