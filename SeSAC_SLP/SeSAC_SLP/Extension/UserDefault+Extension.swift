//
//  UserDefault+Extension.swift
//  SeSAC_SLP
//
//  Created by 김지현 on 2022/01/24.
//

import Foundation
import UIKit

@propertyWrapper
struct UserDefault<Value> {
    let key: String
    let defaultValue: Value
    let container: UserDefaults = .standard
    
    var wrappedValue: Value {
        get { return container.object(forKey: key) as? Value ?? defaultValue }
        set { container.set(newValue, forKey: key)}
    }
}

extension UserDefaults {
    // 어떻게 다른 줄인데 연결이 되는거지 ?
    @UserDefault (key: "beforeAuth", defaultValue: false)
    static var beforeAuth: Bool
    
    @UserDefault (key: "idToken", defaultValue: "")
    static var idToken: String

    @UserDefault (key: "nickname", defaultValue: "")
    static var nickname: String
    
    @UserDefault (key: "birthday", defaultValue: Date())
    static var birthday: Date
    
    @UserDefault (key: "age", defaultValue: 0)
    static var age: Int
    
    @UserDefault (key: "email", defaultValue: "")
    static var email: String
    
    @UserDefault (key: "gender", defaultValue: .none)
    static var gender: Gender
}
