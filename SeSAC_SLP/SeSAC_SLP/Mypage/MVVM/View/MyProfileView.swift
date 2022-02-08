//
//  MyProfileView.swift
//  SeSAC_SLP
//
//  Created by 김지현 on 2022/02/02.
//

import Foundation
import SnapKit
import UIKit

class MyProfileView: UIView {
    
    let deviceWidthRatio = UIScreen.main.bounds.width / 375
    let deviceHeightRatio = UIScreen.main.bounds.height / 812
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    let profileCardView = UIView()
    let profileStackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        constraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        
        self.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(profileCardView)
        contentView.addSubview(profileStackView)
    }
    
    func constraints() {
        
        scrollView.snp.makeConstraints { make in
            make.top.bottom.equalTo(self.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        profileCardView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(16)
            //height 설정해주어야 할텐데
        }
        
        profileStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(profileCardView.snp.bottom).inset(24)
            make.bottom.equalToSuperview().inset(54)
            make.height.equalTo(344)
        }
    
    }
}
