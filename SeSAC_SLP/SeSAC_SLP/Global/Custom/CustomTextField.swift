//
//  CustomTextField.swift
//  SeSAC_SLP
//
//  Created by 김지현 on 2022/01/19.
//

import Foundation
import UIKit
import SnapKit
import SkyFloatingLabelTextField

class TextFieldWithMsg: SkyFloatingLabelTextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        self.font = .title4_R14
        self.errorLabel.font = .body4_R12
        self.backgroundColor = .white
        self.borderStyle = .none
        self.errorMessagePlacement = .bottom
        self.lineHeight = 1.0
        self.title = ""
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        
        let height = bounds.size.height - titleHeight() - selectedLineHeight
        
        let rect = CGRect(
            x: bounds.origin.x + 12,
            y: titleHeight() - 24,
            width: bounds.size.width - 12,
            height: height
        )
        return rect
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        
        let height = bounds.size.height - titleHeight() - selectedLineHeight
        
        let rect = CGRect(
            x: bounds.origin.x + 12,
            y: titleHeight() - 24,
            width: bounds.size.width - 12,
            height: height
        )
        return rect
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        
        let height = bounds.size.height - titleHeight() - selectedLineHeight

        let rect = CGRect(
            x: 12,
            y: titleHeight() - 24,
            width: bounds.size.width - 12,
            height: height
        )
        return rect
    }
    
    override func errorLabelRectForBounds(_ bounds: CGRect, editing: Bool) -> CGRect {
        let lineRect = lineViewRectForBounds(bounds, editing: editing)
        if editing {
            let originY = lineRect.origin.y + selectedLineHeight + 4
            return CGRect(x: 12, y: originY, width: bounds.size.width, height: errorHeight())
        }
        let originY = lineRect.origin.y + selectedLineHeight + errorHeight() + 4
        return CGRect(x: 12, y: originY, width: bounds.size.width, height: errorHeight())
    }
}

class UnderlineTextField: UITextField {
    
    lazy var placeholderColor: UIColor = self.tintColor
    lazy var placeholderString: String = ""
    
    private lazy var underLineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = .white
        return lineView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        target()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setup()
        target()
    }
    
    private func setup() {
        
        self.font = .title4_R14
        
        self.addSubview(underLineView)
        
        underLineView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
        
    }
    
    private func target() {
        self.addTarget(self, action: #selector(editingDidBegin), for: .editingDidBegin)
        self.addTarget(self, action: #selector(editingDidEnd), for: .editingDidEnd)
    }
    
    func setPlaceholder() {
        self.attributedPlaceholder = NSAttributedString(
            string: placeholderString,
            attributes: [NSAttributedString.Key.foregroundColor: placeholderColor]
        )
    }
    
    func setPlaceholder(_ placeholder: String?, color: UIColor, underlineColor: UIColor) {
        if let placeholder = placeholder { self.placeholderString = placeholder }
        self.placeholderColor = color
        setPlaceholder()
        underLineView.backgroundColor = underlineColor
    }
    
    func setFocused(tintColor: UIColor, underlineColor: UIColor) {
        self.tintColor = tintColor
        
        setPlaceholder()
        underLineView.backgroundColor = underlineColor
    }
    
//    func setError() {
//        self.attributedPlaceholder = NSAttributedString(
//            string: placeholderString,
//            attributes: [NSAttributedString.Key.foregroundColor: UIColor.error!]
//        )
//        underLineView.backgroundColor = .error
//    }
//
//    func setSuccess() {
//        self.attributedPlaceholder = NSAttributedString(
//            string: placeholderString,
//            attributes: [NSAttributedString.Key.foregroundColor: UIColor.success!]
//        )
//        underLineView.backgroundColor = .success
//    }
}

extension UnderlineTextField {
    
    @objc func editingDidBegin() {
        setPlaceholder()
        underLineView.backgroundColor = self.tintColor
    }
    
    @objc func editingDidEnd() {
        underLineView.backgroundColor = placeholderColor
    }
}
