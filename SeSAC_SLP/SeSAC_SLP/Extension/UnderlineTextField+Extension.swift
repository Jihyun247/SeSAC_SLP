//
//  UITextField+Extension.swift
//  SeSAC_SLP
//
//  Created by 김지현 on 2022/01/19.
//

import Foundation
import UIKit
import SkyFloatingLabelTextField

extension UnderlineTextField {
    
    func setBasic(placeholder: String, leftPadding: Double) {
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

extension TextFieldWithMsg {
    
    func setBasic(placeholder: String, leftPadding: Double) {
        self.placeholder = placeholder
        self.errorMessage = ""
        self.addLeftPadding(padding: leftPadding)
        self.placeholderColor = .sesacGray7
        self.textColor = .sesacBlack
        self.lineColor = .sesacGray3
        self.selectedLineColor = .focus
    }
    
    func setSuccess(text: String) {
        self.errorColor = .success
        self.errorMessage = text
    }
    
    func setError(text: String) {
        self.errorColor = .error
        self.errorMessage = text
    }
    
}
