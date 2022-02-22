//
//  ResultNearSesacView.swift
//  SeSAC_SLP
//
//  Created by 김지현 on 2022/02/21.
//

import UIKit

enum ResultViewType {
    case near, received
}

class ResultSesacView: UIView {
    
    let deviceWidthRatio = UIScreen.main.bounds.width / 375
    let deviceHeightRatio = UIScreen.main.bounds.height / 812
    
    let noSesacView = UIView()
    let guideLabel = UILabel()
    let subGuideLabel = UILabel()
    let sesacImageView = UIImageView()
    
    let changeHobbyButton = UIButton()
    let refreshButton = UIButton()
    
    let sesacTableView = UITableView()
    
    
    
    convenience init(status: ResultViewType) {
        self.init(frame: .zero)
        
        setup(status: status)
        constraints()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(status: ResultViewType) {

        switch status {
        case .near:
            guideLabel.display1(text: "아쉽게도 주변에 새싹이 없어요ㅠ", textColor: .sesacBlack)
        case .received:
            guideLabel.display1(text: "아직 받은 요청이 없어요ㅠ", textColor: .sesacBlack)
        }
        
        sesacImageView.image = UIImage(named: "nosesac")
        subGuideLabel.title4(text: "취미를 변경하거나 조금만 더 기다려 주세요!", textColor: .sesacGray7)
        
        changeHobbyButton.fill(text: "취미 변경하기", radiusStatus: true)
        refreshButton.setImage(UIImage(named: "bt_refresh"), for: .normal)
        
        sesacTableView.separatorColor = .clear
        sesacTableView.register(ProfileCardTableViewCell.self, forCellReuseIdentifier: ProfileCardTableViewCell.identifier)
        
        [noSesacView, sesacTableView].forEach { self.addSubview($0) }
        [guideLabel, subGuideLabel, sesacImageView, changeHobbyButton, refreshButton].forEach { noSesacView.addSubview($0) }
    }
    
    func constraints() {

        noSesacView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(self.safeAreaLayoutGuide)
        }
        
        sesacImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(0.7)
            make.size.equalTo(64)
        }
        
        guideLabel.snp.makeConstraints { make in
            make.top.equalTo(sesacImageView.snp.bottom).offset(36)
            make.centerX.equalToSuperview()
        }
        
        subGuideLabel.snp.makeConstraints { make in
            make.top.equalTo(guideLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        
        changeHobbyButton.snp.makeConstraints { make in
            make.leading.bottom.equalToSuperview().inset(16)
            make.height.equalTo(48)
            make.trailing.equalTo(refreshButton.snp.leading).offset(-8)
        }
        
        refreshButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalTo(changeHobbyButton.snp.centerY)
            make.size.equalTo(48)
        }
        
        sesacTableView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
