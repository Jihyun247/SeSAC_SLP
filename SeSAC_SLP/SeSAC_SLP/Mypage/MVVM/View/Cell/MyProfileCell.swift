//
//  MySimpleProfileCell.swift
//  SeSAC_SLP
//
//  Created by 김지현 on 2022/01/28.
//

import UIKit
import SnapKit

class MySimpleProfileCell: UIView {
    
    let deviceWidthRatio = UIScreen.main.bounds.width / 375

    let profileImageView = UIImageView()
    let nicknameLabel = UILabel()
    let arrowImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        constraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        [profileImageView, nicknameLabel, arrowImageView].forEach {
            self.addSubview($0)
        }
        
        profileImageView.image = UIImage(named: "profile_img")
        
        nicknameLabel.title1(text: "김새싹", textColor: .sesacBlack)
        
        arrowImageView.image = UIImage(named: "more_arrow")
    }
        
    func constraints() {
        
        self.snp.makeConstraints { make in
            make.height.equalTo(96)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.size.equalTo(48)
            make.leading.equalToSuperview().offset(16)
        }
        nicknameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(profileImageView.snp.centerY)
            make.width.greaterThanOrEqualTo(45)
            make.height.greaterThanOrEqualTo(26)
            make.leading.equalTo(profileImageView.snp.trailing).offset(13)
        }
        arrowImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.size.equalTo(24)
            make.leading.equalTo(nicknameLabel.snp.trailing).offset(213*deviceWidthRatio)
            // 왜 make.trailing.equalToSuperView().offset(-16) 이 안되니...
        }

    }
}
