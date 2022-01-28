//
//  MyInfoCell.swift
//  SeSAC_SLP
//
//  Created by 김지현 on 2022/01/28.
//

import UIKit
import SnapKit

class MyInfoCell: UITableViewCell {
    
    static let identifier = "MyInfoCell"
    
    var separator = UIView()
    let iconImageView = UIImageView()
    let label = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
        constraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        
        separator = UIView(frame: CGRect(x: 16, y: 0, width: UIScreen.main.bounds.width - 32, height: 1))
        separator.backgroundColor = .sesacGray2
        
        iconImageView.image = UIImage(named: "comment")
        iconImageView.tintColor = .sesacBlack
        
        label.title2(text: "텍스트", textColor: .sesacBlack)
        
        [separator, iconImageView, label].forEach {
            contentView.addSubview($0)
        }
    }
        
    func constraints() {
        
        contentView.snp.makeConstraints { make in
            make.height.greaterThanOrEqualTo(75)
        }

        iconImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.size.greaterThanOrEqualTo(24)
            make.leading.equalToSuperview().inset(16)
        }
        label.snp.makeConstraints { make in
            make.centerY.equalTo(iconImageView.snp.centerY)
            make.height.greaterThanOrEqualTo(26)
            make.width.greaterThanOrEqualTo(96)
            make.leading.equalTo(iconImageView.snp.trailing).offset(14)
        }

    }
}
