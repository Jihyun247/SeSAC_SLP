//
//  UITextField+Extension.swift
//  SeSAC_SLP
//
//  Created by 김지현 on 2022/01/19.
//

import Foundation
import UIKit

extension UnderlineTextField {
    
    func setBasic(placeholder: String, leftPadding: Double) {
        self.addLeftPadding(padding: leftPadding)
        self.setFocused(tintColor: .sesacBlack, underlineColor: .sesacBlack)
        self.setPlaceholder(placeholder, color: .sesacGray7, underlineColor: .sesacGray3)
    }
    
    func setSuccess() {
        self.setFocused(tintColor: .sesacBlack, underlineColor: .sesacBlack)
        self.setPlaceholder(nil, color: .sesacGray7, underlineColor: .success)
    }
    
    func setError() {
        self.setFocused(tintColor: .sesacBlack, underlineColor: .sesacBlack)
        self.setPlaceholder(nil, color: .sesacGray7, underlineColor: .error)
    }
    
}
