//
//  APIService.swift
//  SeSAC_SLP
//
//  Created by 김지현 on 2022/01/18.
//

import UIKit
import Moya

struct APIService {

    static let shared = APIService()
    let provider = MoyaProvider<APITarget>()

    func login(completion: @escaping (NetworkResult<User>) -> Void) {

        let target: APITarget = .login(idtoken: UserDefaults.idToken)
        
       requestResultData(target, completion: completion)
    }
    
    func signup(completion: @escaping (NetworkResult<Void>) -> Void) {
        
        let target: APITarget = .signup(idtoken: UserDefaults.idToken, phoneNumber: UserDefaults.phoneNumber, FCMtoken: UserDefaults.fcmToken, nick: UserDefaults.nickname, birth: UserDefaults.birthday, email: UserDefaults.email, gender: UserDefaults.gender)

        requestResultNoData(target, completion: completion)
    }
    
    func onqueue(_ region: Int, _ lat: Double, _ long: Double, completion: @escaping (NetworkResult<AroundQueue>) -> Void) {
        
        let target: APITarget = .onqueue(idtoken: UserDefaults.idToken, region: region, lat: lat, long: long)
        
        requestResultData(target, completion: completion)
    }
    
    func queue(_ region: Int, _ lat: Double, _ long: Double, hf: [String], completion: @escaping (NetworkResult<Void>) -> Void) {

        let target: APITarget = .queue(idtoken: UserDefaults.idToken, type: 2, region: region, lat: lat, long: long, hf: hf)

        requestResultNoData(target, completion: completion)
    }
    
    func deleteQueue(completion: @escaping (NetworkResult<Void>) -> Void) {
        
        let target: APITarget = .deleteQueue(idtoken: UserDefaults.idToken)
        
        requestResultNoData(target, completion: completion)
    }
}

extension APIService {
    
    func requestResultData<T: Codable>(_ target: APITarget, completion: @escaping (NetworkResult<T>) -> Void) {
        
        provider.request(target) { result in
            switch result {
            case .success(let response):
                
                switch response.statusCode {
                case HTTPStatusCode.OK.rawValue:
                    do {
                        let decoder = JSONDecoder()
                        let body = try decoder.decode(T.self, from: response.data)
                        completion(.success(body))
                    } catch {
                        print("구조 확인")
                    }
                case ...300 :
                    completion(.uncommon(response.statusCode))
                case HTTPStatusCode.FIREBASE_TOKEN_ERROR.rawValue:
                    FirebaseUtility.renewalToken { result in
                        switch result {
                        case .success(let token):
                            UserDefaults.idToken = token
                            completion(.tokenExpiration)
                        case .failure(let error):
                            print(error.localizedDescription)
                            completion(.fail)
                        }
                    }
                case HTTPStatusCode.UNSUBSCRIBED_USER.rawValue:
                    print("미가입 유저")
                    DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {return}
                        windowScene.windows.first?.rootViewController = OnboardingViewController()
                        windowScene.windows.first?.makeKeyAndVisible()
                    }
                case HTTPStatusCode.SERVER_ERROR.rawValue:
                    print("서버에러")
                    completion(.fail)
                case HTTPStatusCode.CLIENT_ERROR.rawValue:
                    print("클라 에러")
                default:
                    print("default")
                }
            case .failure(let err):
                print(err)
                completion(.fail)
            }
        }
    }
    
    func requestResultNoData(_ target: APITarget, completion: @escaping (NetworkResult<Void>) -> Void) {

        provider.request(target) { result in
            switch result {
            case .success(let response):
                
                switch response.statusCode {
                case HTTPStatusCode.OK.rawValue:
                    completion(.success(nil))
                case ...300:
                    completion(.uncommon(response.statusCode))
                case HTTPStatusCode.FIREBASE_TOKEN_ERROR.rawValue:
                    FirebaseUtility.renewalToken { result in
                        switch result {
                        case .success(let token):
                            UserDefaults.idToken = token
                            completion(.tokenExpiration)
                        case .failure(let error):
                            print(error.localizedDescription)
                            completion(.fail)
                        }
                    }
                case HTTPStatusCode.UNSUBSCRIBED_USER.rawValue:
                    print("미가입 유저")
                    DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {return}
                        windowScene.windows.first?.rootViewController = OnboardingViewController()
                        windowScene.windows.first?.makeKeyAndVisible()
                    }
                case HTTPStatusCode.SERVER_ERROR.rawValue:
                    print("서버 에러")
                    completion(.fail)
                case HTTPStatusCode.CLIENT_ERROR.rawValue:
                    print("클라이언트 에러")
                default:
                    print("default")
                }
            case .failure(let err):
                print(err)
                
            }
        }
    }

}
