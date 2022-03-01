//
//  HobbyCollectionViewCell.swift
//  SeSAC_SLP
//
//  Created by 김지현 on 2022/02/12.
//

import UIKit
import SnapKit

enum HobbyType {
    case myHobby, otherHobby
}

class HobbyCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "HobbyCollectionViewCell"
    
    var hobbyButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(hobbyType: HobbyType) {

        layoutIfNeeded()
        contentView.setBorderColorAndRadius(cornerRadius: 8)
        switch hobbyType {
        case .myHobby:
            hobbyButton = MyHobbyButton()
            hobbyButton.setTitle("내취미", for: .normal)
            hobbyButton.semanticContentAttribute = .forceRightToLeft
        case .otherHobby:
            hobbyButton = OtherHobbyButton()
            hobbyButton.setTitle("다른사람", for: .normal)
        }
        contentView.addSubview(hobbyButton)
        
        constraints()
    }
    
    func constraints() {
        
        hobbyButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

