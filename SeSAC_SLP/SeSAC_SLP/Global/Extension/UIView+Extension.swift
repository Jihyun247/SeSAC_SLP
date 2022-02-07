//
//  UIView+Extension.swift
//  SeSAC_SLP
//
//  Created by 김지현 on 2022/01/19.
//

import Foundation
import UIKit

extension UIView {
    
    func setBorderColorAndRadius(borderColor: UIColor = .clear, borderWidth: CGFloat = 0, cornerRadius: CGFloat) {
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
    }
    
    func setCircleRadius(frameWidth: CGFloat) {
        self.layer.cornerRadius = frameWidth/2
        self.layer.masksToBounds = true
    }
}
