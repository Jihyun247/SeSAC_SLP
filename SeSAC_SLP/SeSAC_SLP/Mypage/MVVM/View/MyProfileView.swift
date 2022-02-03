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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        constraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        
//        tableView.register(MyInfoCell.self, forCellReuseIdentifier: MyInfoCell.identifier)
//        tableView.separatorColor = .clear
//
//        [profileView, tableView].forEach { self.addSubview($0) }
    }
    
    func constraints() {
    
    }
}
