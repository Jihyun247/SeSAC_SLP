//
//  User.swift
//  SeSAC_SLP
//
//  Created by 김지현 on 2022/01/25.
//

import Foundation

// MARK: - User
struct User: Codable {
    let id: String
    let reputation: [Int]
    let comment: [String]
    let sesacCollection, backgroundCollection: [Int]
    let purchaseToken, transactionID, reviewedBefore, reportedUser: [String]
    let uid, phoneNumber, fcMtoken, nick: String
    let birth, email: String
    let gender, sesac: Int
    let hobby: String
    let dodgepenalty, background, ageMin, ageMax: Int
    let dodgeNum, searchable, reportedNum: Int
    let createdAt: String
    let v: Int

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case reputation, comment, sesacCollection, backgroundCollection, purchaseToken
        case transactionID = "transactionId"
        case reviewedBefore, reportedUser, uid, phoneNumber
        case fcMtoken = "FCMtoken"
        case nick, birth, email, gender, sesac, hobby, dodgepenalty, background, ageMin, ageMax, dodgeNum, searchable, reportedNum, createdAt
        case v = "__v"
    }
}
