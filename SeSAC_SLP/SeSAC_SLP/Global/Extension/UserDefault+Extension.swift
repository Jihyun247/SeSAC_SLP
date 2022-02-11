//
//  UserDefault+Extension.swift
//  SeSAC_SLP
//
//  Created by 김지현 on 2022/01/24.
//

import Foundation
import UIKit


// UserDefault에 Custom Object 넣는 방법 오늘 해결 !!
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
    
    @UserDefault (key: "phoneNumber", defaultValue: "")
    static var phoneNumber: String
    
    @UserDefault (key: "idToken", defaultValue: "")
    static var idToken: String
    
    @UserDefault (key: "fcmToken", defaultValue: "")
    static var fcmToken: String

    @UserDefault (key: "nickname", defaultValue: "")
    static var nickname: String
    
    @UserDefault (key: "birthday", defaultValue: "")
    static var birthday: String
    
    @UserDefault (key: "age", defaultValue: 0)
    static var age: Int
    
    @UserDefault (key: "email", defaultValue: "")
    static var email: String
    
    @UserDefault (key: "gender", defaultValue: -1)
    static var gender: Int
    
    @UserDefault (key: "lat", defaultValue: 37.51818789942772)
    static var lat: Double
    
    @UserDefault (key: "long", defaultValue: 126.88541765534976)
    static var long: Double
    
    @UserDefault (key: "region", defaultValue: 1275130688)
    static var region: Int
    
    @UserDefault (key: "matchingStatus", defaultValue: 0)
    static var matchingStatus: Int
}
