//
//  MyInfoView.swift
//  SeSAC_SLP
//
//  Created by 김지현 on 2022/01/28.
//

import Foundation
import SnapKit
import UIKit

class MyInfoView: UIView {
    
    let deviceWidthRatio = UIScreen.main.bounds.width / 375
    let deviceHeightRatio = UIScreen.main.bounds.height / 812
    
    let profileView = MySimpleProfileCell()
    let tableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        constraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        
        tableView.register(MyInfoCell.self, forCellReuseIdentifier: MyInfoCell.identifier)
        tableView.separatorColor = .clear
        
        [profileView, tableView].forEach { self.addSubview($0) }
    }
    
    func constraints() {
        
        profileView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(96)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(profileView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

