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

class LabelUnderImgButton: UIButton {

    private enum Constants {
        static let imageSize: CGFloat = 64
        static let titleHeight: CGFloat = 26
    }

    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        if #available(iOS 15, *) {
           return super.titleRect(forContentRect: contentRect)
        }
        else {
            _ = super.titleRect(forContentRect: contentRect)
            return CGRect(
                x: 0,
                y: contentRect.height - Constants.titleHeight,
                width: contentRect.width,
                height: Constants.titleHeight
            )
        }
    }

    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        if #available(iOS 15, *) {
           return super.imageRect(forContentRect: contentRect)
        } else {
            return CGRect(
                x: contentRect.width / 2 - Constants.imageSize / 2,
                y: (contentRect.height - titleRect(forContentRect: contentRect).height) / 2 - Constants.imageSize / 2,
                width: Constants.imageSize,
                height: Constants.imageSize
            )
        }
    }

    override var intrinsicContentSize: CGSize {
        if #available(iOS 15, *) {
           return super.intrinsicContentSize
        }
        else {
            _ = super.intrinsicContentSize
            let size = titleLabel?.sizeThatFits(contentRect(forBounds: bounds).size) ?? .zero
            let spacing: CGFloat = 12
            return CGSize(
                width: max(size.width, Constants.imageSize),
                height: Constants.imageSize + Constants.titleHeight + spacing
            )
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        if #available(iOS 15, *) {
            var myConfiguration = UIButton.Configuration.plain()
            myConfiguration.imagePlacement = .top
            self.configuration = myConfiguration
        } else {
            titleLabel?.textAlignment = .center
        }
    }
}


extension LabelUnderImgButton {
    
    func pressed() {
        self.backgroundColor = .sesacWhiteGreen
        self.setBorderColorAndRadius(cornerRadius: 8.0)
    }
    
    func unpressed() {
        self.backgroundColor = .white
        self.setBorderColorAndRadius(borderColor: .sesacGray3, borderWidth: 1.0, cornerRadius: 8.0)
    }
}
