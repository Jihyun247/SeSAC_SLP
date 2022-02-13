//
//  LabelUnderImgButton.swift
//  SeSAC_SLP
//
//  Created by 김지현 on 2022/02/13.
//

import UIKit

class LabelUnderImgButton: UIButton {
    
    convenience init(image: UIImage, title: String) {
        self.init(frame: .zero)
        setup(image, title)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(_ image: UIImage, _ title: String) {
        if #available(iOS 15, *) {
            var myConfiguration = UIButton.Configuration.plain()
            myConfiguration.imagePlacement = .top
            myConfiguration.image = image
            myConfiguration.attributedTitle = AttributedString(title, attributes: AttributeContainer([NSAttributedString.Key.foregroundColor: UIColor.sesacBlack, NSAttributedString.Key.font: UIFont.title2_R16!]))
            self.configuration = myConfiguration
        } else {
            imageView?.image = image
            titleLabel?.title2(text: title, textColor: .sesacBlack)
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
