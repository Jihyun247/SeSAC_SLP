//
//  APITarget.swift
//  SeSAC_SLP
//
//  Created by 김지현 on 2022/01/18.
//

import Foundation
import Moya

enum APITarget { // 토큰 쿼리 파라미터 바디 모두 입력
    case signup(idtoken: String, phoneNumber: String, FCMtoken: String, nick: String, birth: String, email: String, gender: Int)
    case login(idtoken: String)
    case deleteUser(idtoken: String)
    case updateFCMtoken(idtoken: String, FCMtoken: String)
    case upsdateMypage(idtoken: String, searchable: Int, ageMin: Int, ageMax: Int, gender: Int, hobby: String)
    case onqueue(idtoken: String, region: Int, lat: Double, long: Double)
    case queue(idtoken: String, type: Int, region: Int, lat: Double, long: Double, hf: [String])
    case deleteQueue(idtoken: String)
}

extension APITarget: TargetType {
    var baseURL: URL {
        return URL(string: "http://test.monocoding.com:35484")!
    }
    
    var path: String { // path에 들어갈 파라미터 넣어주기
        switch self {
        case .signup, .login:
            return "/user"
        case .deleteUser:
            return "/user/withdraw"
        case .updateFCMtoken:
            return "/user/update_fcm_token"
        case .upsdateMypage:
            return "/user/update/mypage"
        case .onqueue:
            return "/queue/onqueue"
        case .queue, .deleteQueue:
            return "/queue"
        }
    }
    
    var method: Moya.Method { // 각 CRUD
        switch self {
        case .signup, .deleteUser, .upsdateMypage, .onqueue, .queue:
            return .post
        case .login:
            return .get
        case .updateFCMtoken:
            return .put
        case .deleteQueue:
            return .delete
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task { // 바디는 JSONEncoding.default, 쿼리가 들어가면 URLEncoding.queryString, 이미지는 .uploadMultipart
        switch self {
        case .login, .deleteUser, .deleteQueue:
            return .requestPlain
        case .signup(_, let phoneNumber, let FCMtoken, let nick, let birth, let email, let gender):
            return .requestParameters(parameters: ["phoneNumber": phoneNumber, "FCMtoken": FCMtoken, "nick": nick, "birth": birth, "email": email, "gender": gender], encoding: JSONEncoding.default)
        case .updateFCMtoken(_, let FCMtoken):
            return .requestParameters(parameters: ["FCMtoken": FCMtoken], encoding: JSONEncoding.default)
        case .upsdateMypage(_, let searchable, let ageMin, let ageMax, let gender, let hobby):
            return .requestParameters(parameters: ["searchable": searchable, "ageMin": ageMin, "ageMax": ageMax, "gender": gender, "hobby": hobby], encoding: JSONEncoding.default)
        case .onqueue(_, let region, let lat, let long):
            return .requestParameters(parameters: ["region": region, "lat": lat, "long": long], encoding: JSONEncoding.default)
        case .queue(_, let type, let region, let lat, let long, let hf):
            return .requestParameters(parameters: ["type": type, "region": region, "lat": lat, "long": long, "hf": hf], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .signup(let idtoken, _,_,_,_,_,_), .login(let idtoken), .deleteUser(let idtoken), .updateFCMtoken(let idtoken, _), .upsdateMypage(let idtoken, _,_,_,_,_), .onqueue(let idtoken,_,_,_), .queue(let idtoken,_,_,_,_,_), .deleteQueue(let idtoken):
            return ["Content-Type" : "application/json", "idtoken" : idtoken]
        }
    }
}
