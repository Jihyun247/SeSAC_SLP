//
//  HobbyButton.swift
//  SeSAC_SLP
//
//  Created by 김지현 on 2022/02/13.
//

import UIKit

class OtherHobbyButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        self.setBackgroundColor(.white, for: .normal)
        self.titleLabel?.font = .title4_R14
        self.setTitleColor(.error, for: .normal)
        self.setBorderColorAndRadius(borderColor: .error, borderWidth: 1, cornerRadius: 8)
    }
}

extension OtherHobbyButton {
    
    func recommanded() {
        self.setTitleColor(.error, for: .normal)
        self.setBorderColorAndRadius(borderColor: .error, borderWidth: 1, cornerRadius: 8)
    }
    
    func near() {
        self.setTitleColor(.sesacGray4, for: .normal)
        self.setBorderColorAndRadius(borderColor: .sesacGray4, borderWidth: 1, cornerRadius: 8)
    }
}

class MyHobbyButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        self.setBackgroundColor(.white, for: .normal)
        self.setTitleColor(.sesacGreen, for: .normal)
        self.setBorderColorAndRadius(borderColor: .sesacGreen, borderWidth: 1, cornerRadius: 8)
        self.titleLabel?.font = .title4_R14
        self.setImage(UIImage(named: "close"), for: .normal)
    }
}
