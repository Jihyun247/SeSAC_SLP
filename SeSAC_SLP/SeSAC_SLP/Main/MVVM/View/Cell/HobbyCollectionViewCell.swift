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
    
    convenience init(hobbyType: HobbyType) {
        self.init(frame: .zero)
        
        setup(hobbyType: hobbyType)
        constraints()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup(hobbyType: .otherHobby)
        constraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(hobbyType: HobbyType) {
        contentView.addSubview(hobbyButton)
        
        switch hobbyType {
        case .myHobby:
            hobbyButton = hobbyButton as! MyHobbyButton
        case .otherHobby:
            hobbyButton = hobbyButton as! OtherHobbyButton
        }
    }
    
    func constraints() {
        
        contentView.snp.makeConstraints { make in
            make.height.equalTo(32)
        }
        
        hobbyButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
