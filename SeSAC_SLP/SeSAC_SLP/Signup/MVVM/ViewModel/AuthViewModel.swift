////
////  AuthViewModel.swift
////  SeSAC_SLP
////
////  Created by 김지현 on 2022/01/21.
////
//
//import Foundation
//import RxSwift
//import RxCocoa
//import Firebase
//import FirebaseAuth
//
//enum LoginResult {
//    case member, notMember, fail
//}
//
//class AuthViewModel: ViewModel {
//
//    var phoneNum = BehaviorRelay<String>(value: "")
//    var verifyCode = BehaviorRelay<String>(value: "")
//
//
//    var disposeBag = DisposeBag()
//
//    struct Input {
//        var inputCode = ControlProperty<String?>
//        let tap: ControlEvent<Void>
//    }
//
//    struct Output {
//        let codeValidStatus: Observable<Bool>
//        let sceneTransition: ControlEvent<Void>
//    }
//
//    func transform(input: Input) -> Output {
//
//        let valid = input.inputCode
//            .orEmpty
//            .distinctUntilChanged()
//            .map { $0.count == 6 }
//            .share(replay: 1, scope: .whileConnected)
//
//        return Output(codeValidStatus: valid, sceneTransition: input.tap)
//    }
//
//    // 인증 후 날라오는 토큰은 Firebase token이 아닌 verificationID 이다.
//    // 따라서 인증 성공시 id토큰을 가져오는 메서드를 추가해야 한다.
//    // 서버 통신 401 코드를 받을 시에도 id토큰을 가져오는 메서드를 똑같이 추가해야 한다.
//    // 모든 서버통신 전엔 네트워크 연결 상태를 확인해야 한다.
//
//    func getVerifyCode(number: String, completion: @escaping (SendResult) -> Void) {
//
//        Auth.auth().languageCode = "ko"
//
//        PhoneAuthProvider.provider().verifyPhoneNumber("+82\(number)", uiDelegate: nil) { verification, error in
//
//            if let verification = verification, error == nil {
//                self.verifyCode.accept(verification)
//                completion(.success)
//
//            } else if verification == nil {
//
//                print("verification code is nil")
//                print("Phone Verification Error: \(error!.localizedDescription) ")
//
//                error!.localizedDescription == "We have blocked all requests from this device due to unusual activity. Try again later." ? completion(.overAccess) : completion(.error)
//            }
//        }
//    }
//
//    func postVerifyCode(completion: @escaping (NetworkResult<Any>) -> Void) {
//
//        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verifyCode.value, verificationCode: inputCode.value)
//
//        Auth.auth().signIn(with: credential) { success, error in
//            if error == nil {
//                print(success ?? "")
//                print("user signed in")
//                completion(.success(nil))
//            } else {
//                print(error.debugDescription)
//                completion(.fail)
//            }
//        }
//    }
//
//    func getFirebaseToken(completion: @escaping (NetworkResult<String>) -> Void) {
//
//        let currentUser = Auth.auth().currentUser
//        currentUser?.getIDTokenForcingRefresh(true) { idToken, error in
//          if let error = error {
//              print(error)
//              completion(.fail)
//              return;
//          }
//            UserDefaults.idToken = idToken ?? ""
//            print("idToken: " + (idToken  ?? ""))
//            completion(.success(nil))
//        }
//    }
//
//    func login(completion: @escaping (LoginResult) -> Void) {
//        APIService.shared.login { result in
//            switch result {
//
//            case .success(let data):
//                guard let userData = data else {
//                    completion(.notMember)
//                    return
//                }
//                // 정보 저장 후 뷰로 이동
//                UserDefaults.nickname = userData.nick
//                UserDefaults.birthday = userData.birth
//                UserDefaults.email = userData.email
//                UserDefaults.gender = userData.gender
//                UserDefaults.fcmToken = userData.fcMtoken
//                print("정보저장")
//                completion(.member)
//            case .fail:
//                completion(.fail)
//            }
//        }
//    }
//
//    func isValid() -> Observable<Bool> {
//        return inputCode.map {  }
//    }
//}


//
//  AuthViewModel.swift
//  SeSAC_SLP
//
//  Created by 김지현 on 2022/01/21.
//

import Foundation
import RxSwift
import RxCocoa
import Firebase
import FirebaseAuth

enum LoginResult {
    case member, notMember, fail
}

class AuthViewModel: ViewModel {
    
    var phoneNum = BehaviorRelay<String>(value: "")
    var verifyCode = BehaviorRelay<String>(value: "")
    
    let getVerifyCodeResult = PublishSubject<SendResult>()
    let postVerifyCodeResult = PublishSubject<NetworkResult<Any>>()
    let getFirebaseTokenResult = PublishSubject<NetworkResult<String>>()
    let loginResult = PublishSubject<LoginResult>()
    
    
    var disposeBag = DisposeBag()
    
    struct Input {
        var inputCode: ControlProperty<String?>
        let resendTap: ControlEvent<Void>
        let nextTap: ControlEvent<Void>
    }

    struct Output {
        let codeValidStatus: Observable<Bool>
        let resendVerifyCode: ControlEvent<Void>
        let verifyCodeStart: ControlEvent<Void>
    }
    
    func transform(input: Input) -> Output {

        let valid = input.inputCode
            .orEmpty
            .distinctUntilChanged()
            .map { $0.count == 6 }
            .share(replay: 1, scope: .whileConnected)
        
        return Output(codeValidStatus: valid, resendVerifyCode: input.resendTap ,verifyCodeStart: input.nextTap)
    }

    func getVerifyCode(number: String) {

        Auth.auth().languageCode = "ko"
        PhoneAuthProvider.provider().verifyPhoneNumber("+82\(number)", uiDelegate: nil) { verification, error in
            
            if let verification = verification, error == nil {
                self.verifyCode.accept(verification)
                self.getVerifyCodeResult.onNext(.success)
            } else if verification == nil {

                print("verification code is nil, Phone Verification Error: \(error!.localizedDescription) ")
                error!.localizedDescription == AuthResponse.blocked.rawValue ? self.getVerifyCodeResult.onNext(.overAccess) : self.getVerifyCodeResult.onNext(.overAccess)
            }
        }
    }
    
    func postVerifyCode(inputCode: String) {

        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verifyCode.value, verificationCode: inputCode)

        Auth.auth().signIn(with: credential) { success, error in
            if error == nil {
                print(success ?? "")
                print("user signed in")
                self.postVerifyCodeResult.onNext(.success(nil))
            } else {
                print(error.debugDescription)
                self.postVerifyCodeResult.onNext(.fail)
            }
        }
    }
    
    func getFirebaseToken() {
        
        let currentUser = Auth.auth().currentUser
        currentUser?.getIDTokenForcingRefresh(true) { idToken, error in
          if let error = error {
              print(error)
              self.getFirebaseTokenResult.onNext(.fail)
              return;
          }
            UserDefaults.idToken = idToken ?? ""
            print("idToken: " + (idToken  ?? ""))
            self.getFirebaseTokenResult.onNext(.success(nil))
        }
    }
    
    func login() {
        APIService.shared.login { result in
            switch result {
                
            case .success(let data):
                guard let userData = data else {
                    self.loginResult.onNext(.notMember)
                    return
                }
                // 정보 저장 후 뷰로 이동
                UserDefaults.nickname = userData.nick
                UserDefaults.birthday = userData.birth
                UserDefaults.email = userData.email
                UserDefaults.gender = userData.gender
                UserDefaults.fcmToken = userData.fcMtoken
                print("정보저장")
                self.loginResult.onNext(.member)
            case .fail:
                self.loginResult.onNext(.fail)
            }
        }
    }
}
