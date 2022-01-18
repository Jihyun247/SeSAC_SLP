//
//  UILabel+Class.swift
//  SeSAC_SLP
//
//  Created by 김지현 on 2022/01/18.
//

import Foundation
import UIKit

class CustomLabel: UILabel {
    
    func setupLabel() {
        self.numberOfLines = 0
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLabel()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabel()
    }
    
    convenience init(text: String, textColor: UIColor, font: UIFont, lineHeightRatio: CGFloat) {
        self.init(frame: .zero)
        self.text = text
        self.textColor = textColor
        self.font = font
        self.lineHeightRatio = lineHeightRatio
    }
}
