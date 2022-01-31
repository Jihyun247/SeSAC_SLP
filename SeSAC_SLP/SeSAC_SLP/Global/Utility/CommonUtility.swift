//
//  CommonUtility.swift
//  SeSAC_SLP
//
//  Created by 김지현 on 2022/01/31.
//

import Foundation
import Firebase
import FirebaseAuth

class FirebaseUtility {
    
    static func renewalToken(completion: @escaping (Result<String, Error>) -> Void) {
        Auth.auth().currentUser?.getIDTokenForcingRefresh(true) { idToken, error in
                                
            if let error = error {
                completion(.failure(error))
                return
            }

            if let idToken = idToken {
                UserDefaults.idToken = idToken
                completion(.success(idToken))
            }
        }
    }
    
    
}
