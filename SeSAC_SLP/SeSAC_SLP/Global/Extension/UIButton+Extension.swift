//
//  UIButton+Extension.swift
//  SeSAC_SLP
//
//  Created by 김지현 on 2022/01/19.
//

import Foundation
import UIKit

extension UIButton {
    
    func inactive(text: String = "", radiusStatus: Bool = true) {
        //self.isEnabled = false
        radiusStatus ? self.setBorderColorAndRadius(borderColor: .sesacGray4, borderWidth: 0.5, cornerRadius: 8) : nil
        if text != "" { self.setTitle(text, for: .normal) }
        self.setTitleColor(.sesacBlack, for: .normal)
        self.setBackgroundColor(.white, for: .normal)
        self.titleLabel?.font = .body3_R14
    }
    
    func fill(text: String = "", radiusStatus: Bool = true) {
        //self.isEnabled = true
        radiusStatus ? self.setBorderColorAndRadius(borderColor: .sesacGreen, borderWidth: 0.5, cornerRadius: 8) : nil
        if text != "" { self.setTitle(text, for: .normal) }
        self.setTitleColor(.white, for: .normal)
        self.setBackgroundColor(.sesacGreen, for: .normal)
        self.titleLabel?.font = .body3_R14
    }
    
    func outline(text: String = "", radiusStatus: Bool = true) {
        //self.isEnabled = true
        radiusStatus ? self.setBorderColorAndRadius(borderColor: .sesacGreen, borderWidth: 0.5, cornerRadius: 8) : nil
        if text != "" { self.setTitle(text, for: .normal) }
        self.setTitleColor(.sesacGreen, for: .normal)
        self.setBackgroundColor(.white, for: .normal)
        self.titleLabel?.font = .body3_R14
    }
    
    func cancel(text: String = "", radiusStatus: Bool = true) {
        //self.isEnabled = true
        radiusStatus ? self.setBorderColorAndRadius(borderColor: .sesacGray2, borderWidth: 0.5, cornerRadius: 8) : nil
        if text != "" { self.setTitle(text, for: .normal) }
        self.setTitleColor(.sesacBlack, for: .normal)
        self.setBackgroundColor(.sesacGray2, for: .normal)
        self.titleLabel?.font = .body3_R14
    }
    
    func disable(text: String = "", radiusStatus: Bool = true) {
        //self.isEnabled = false
        radiusStatus ? self.setBorderColorAndRadius(borderColor: .clear, borderWidth: 0, cornerRadius: 8) : nil
        if text != "" { self.setTitle(text, for: .normal) }
        self.setTitleColor(.sesacGray3, for: .normal)
        self.setBackgroundColor(.sesacGray7, for: .normal)
        self.titleLabel?.font = .body3_R14
    }
    
    func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
        UIGraphicsBeginImageContext(CGSize(width: 1.0, height: 1.0))
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setFillColor(color.cgColor)
        context.fill(CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0))
        
        let backgroundImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
         
        self.setBackgroundImage(backgroundImage, for: state)
    }
    
    func recommended() {
        self.setTitleColor(.error, for: .normal)
        self.setBorderColorAndRadius(borderColor: .error, borderWidth: 1, cornerRadius: 8)
    }
    
    func near() {
        self.setTitleColor(.sesacGray4, for: .normal)
        self.setBorderColorAndRadius(borderColor: .sesacGray4, borderWidth: 1, cornerRadius: 8)
    }
    
    func requestMatching() {
        self.titleLabel?.font = .title3_M14
        self.setTitle("요청하기", for: .normal)
        self.setTitleColor(.white, for: .normal)
        self.setBackgroundColor(.error, for: .normal)
        self.setBorderColorAndRadius(cornerRadius: 8.0)
    }
    
    func receiveMatching() {
        self.titleLabel?.font = .title3_M14
        self.setTitle("수락하기", for: .normal)
        self.setTitleColor(.white, for: .normal)
        self.setBackgroundColor(.success, for: .normal)
        self.setBorderColorAndRadius(cornerRadius: 8.0)
    }
}
