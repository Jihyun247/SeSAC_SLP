//
//  CustomUIButton.swift
//  SeSAC_SLP
//
//  Created by 김지현 on 2022/01/19.
//

import Foundation
import UIKit

class InactiveButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        self.isEnabled = false
        self.setBorderColorAndRadius(borderColor: .sesacGray4, borderWidth: 0.5, cornerRadius: 8)
        self.setTitleColor(.sesacBlack, for: .normal)
        self.setBackgroundColor(.white, for: .normal)
        self.titleLabel?.font = .body3_R14
    }
}

class FillButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        self.isEnabled = true
        self.setBorderColorAndRadius(borderColor: .sesacGreen, borderWidth: 0.5, cornerRadius: 8)
        self.setTitleColor(.white, for: .normal)
        self.setBackgroundColor(.sesacGreen, for: .normal)
        self.titleLabel?.font = .body3_R14
    }
}

class OutlineButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        self.isEnabled = true
        self.setBorderColorAndRadius(borderColor: .sesacGreen, borderWidth: 0.5, cornerRadius: 8)
        self.setTitleColor(.sesacGreen, for: .normal)
        self.setBackgroundColor(.white, for: .normal)
        self.titleLabel?.font = .body3_R14
    }
}

class CancelButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        self.isEnabled = true
        self.setBorderColorAndRadius(borderColor: .sesacGray2, borderWidth: 0.5, cornerRadius: 8)
        self.setTitleColor(.sesacBlack, for: .normal)
        self.setBackgroundColor(.sesacGray2, for: .normal)
        self.titleLabel?.font = .body3_R14
    }
}

class DisableButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        self.isEnabled = false
        self.setBorderColorAndRadius(borderColor: .sesacGray6, borderWidth: 0.5, cornerRadius: 8)
        self.setTitleColor(.sesacGray3, for: .normal)
        self.setBackgroundColor(.sesacGray6, for: .normal)
        self.titleLabel?.font = .body3_R14
    }
}
