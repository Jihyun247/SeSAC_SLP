//
//  Friend.swift
//  SeSAC_SLP
//
//  Created by 김지현 on 2022/02/09.
//

import Foundation

// MARK: - AroundQueue
struct AroundQueue: Codable {
    let fromQueueDB, fromQueueDBRequested: [AroundUser]
    let fromRecommend: [String]
}

// MARK: - QueueDB
struct AroundUser: Codable {
    let uid, nick: String
    let lat, long: Double
    let reputation: [Int]
    let hf, reviews: [String]
    let gender, type, sesac, background: Int
}
