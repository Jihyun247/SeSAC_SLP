//
//  SignupHTTPViewModel.swift
//  SeSAC_SLP
//
//  Created by 김지현 on 2022/01/31.
//

import Foundation
import RxSwift
import RxCocoa
import Firebase
import FirebaseAuth
import AVFoundation

class SignupHTTPViewModel {
    
    var verifyCode = BehaviorRelay<String>(value: "")

    let postVerifyCodeResult = PublishSubject<Result<AuthDataResult, Error>>()
    let getFirebaseTokenResult = PublishSubject<Result<String, Error>>()
    let loginResult = PublishSubject<LoginResult>()
    let signupResult = PublishSubject<SignupResult>()
    
    func getVerifyCode(number: String, completion: @escaping (SendResult) -> Void) {
        
        Auth.auth().languageCode = "ko"
        
        PhoneAuthProvider.provider().verifyPhoneNumber("+82\(number)", uiDelegate: nil) { verification, error in
            
            if let verification = verification, error == nil {
                var phoneNum = number.components(separatedBy: ["-"]).joined()
                print("+82\(phoneNum.removeFirst())")
                UserDefaults.phoneNumber = "+82\(phoneNum.removeFirst())"
                self.verifyCode.accept(verification)
                completion(.success)
                
            } else if verification == nil {

                print("verification code is nil")
                print("Phone Verification Error: \(error!.localizedDescription) ")
                
                error!.localizedDescription == AuthResponse.blocked.rawValue ? completion(.overAccess) : completion(.error)
            }
        }
    }
    
    func postVerifyCode(inputCode: String) {

        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verifyCode.value, verificationCode: inputCode)

        Auth.auth().signIn(with: credential) { success, error in
            
            if let success = success, error == nil {
                print("user signed in: \(success)")
                self.postVerifyCodeResult.onNext(.success(success))
            } else {
                print(error.debugDescription)
                self.postVerifyCodeResult.onNext(.failure(error!))
            }
        }
    }
    
    func getFirebaseToken() {
        
        let currentUser = Auth.auth().currentUser
        currentUser?.getIDTokenForcingRefresh(true) { idToken, error in
            
            if let error = error {
                print(error)
                self.getFirebaseTokenResult.onNext(.failure(error))
                return;
            }
            
            if let idToken = idToken {
                UserDefaults.idToken = idToken
                print("idToken: \(idToken)")
                self.getFirebaseTokenResult.onNext(.success(idToken))
            }
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

                UserDefaults.nickname = userData.nick
                UserDefaults.birthday = userData.birth
                UserDefaults.email = userData.email
                UserDefaults.gender = userData.gender
                UserDefaults.fcmToken = userData.fcMtoken
                print("정보저장")
                self.loginResult.onNext(.member)
            case .tokenExpiration(_):
                self.login()
            case .fail:
                self.loginResult.onNext(.fail)
            }
        }
    }
    
    func signup() {
        APIService.shared.signup { result in
            
            switch result {
                
            case .success(let successCase):
                if successCase == SignupStatusCode.ALREADY_SIGNIN.rawValue {
                    self.signupResult.onNext(.alreadyUser)
                } else if successCase == SignupStatusCode.CANT_USE_NICKNAME.rawValue {
                    self.signupResult.onNext(.cantUseNickname)
                } else {
                    self.signupResult.onNext(.success)
                }
            case .tokenExpiration(_):
                self.signup()
            case .fail:
                self.signupResult.onNext(.fail)
            }
        }
    }
}
