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

    func login(completion: @escaping (NetworkResult<User>) -> Void) {

        let target: APITarget = .login(idtoken: UserDefaults.idToken)
        
        provider.request(target) { result in
            switch result {
            case .success(let response):
                
                switch response.statusCode {
                case HTTPStatusCode.OK.rawValue:
                    do {
                        let decoder = JSONDecoder()
                        let body = try decoder.decode(User.self, from: response.data)
                        print("기존 회원")
                        completion(.success(body))
                    } catch {
                        print("구조 확인")
                        completion(.fail)
                    }
                case LoginStatusCode.NOT_USER.rawValue:
                    print("기존 회원 아님")
                    completion(.success(nil))
                case HTTPStatusCode.FIREBASE_TOKEN_ERROR.rawValue:
                    FirebaseUtility.renewalToken { result in
                        switch result {
                        case .success(let token):
                            completion(.tokenExpiration(token))
                        case .failure(let error):
                            print(error.localizedDescription)
                            completion(.fail)
                        }
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
    
    func signup(completion: @escaping (NetworkResult<Int>) -> Void) {
        
        let target: APITarget = .signup(idtoken: UserDefaults.idToken, phoneNumber: UserDefaults.phoneNumber, FCMtoken: UserDefaults.fcmToken, nick: UserDefaults.nickname, birth: UserDefaults.birthday, email: UserDefaults.email, gender: UserDefaults.gender)
        
        provider.request(target) { result in
            switch result {
            case .success(let response):
                
                switch response.statusCode {
                case 200..<300:
                    completion(.success(response.statusCode))
                case HTTPStatusCode.FIREBASE_TOKEN_ERROR.rawValue:
                    FirebaseUtility.renewalToken { result in
                        switch result {
                        case .success(let token):
                            completion(.tokenExpiration(token))
                        case .failure(let error):
                            print(error.localizedDescription)
                            completion(.fail)
                        }
                    }
                case HTTPStatusCode.SERVER_ERROR.rawValue:
                    print("서버 에러")
                    completion(.fail)
                case HTTPStatusCode.CLIENT_ERROR.rawValue:
                    print("클라이언트 에러")
                default:
                    print("default")
                }
                
                print(response.statusCode)
            case .failure(let err):
                print(err)
                
            }
        }
        
    }
}
