//
//  ResultRequestView.swift
//  SeSAC_SLP
//
//  Created by 김지현 on 2022/02/20.
//

import UIKit
import SnapKit
import Tabman

class ResultRequestView: UIView {
    
    let deviceWidthRatio = UIScreen.main.bounds.width / 375
    let deviceHeightRatio = UIScreen.main.bounds.height / 812
    
    let bar = TMBar.ButtonBar()
    
    let buttonView = UIView()
    let changeHobbyButton = UIButton()
    let refreshButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        constraints()
    } 
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        
        bar.layout.transitionStyle = .snap
        bar.layout.contentMode = .fit
        //bar.indicator.backgroundColor = .white
        bar.indicator.tintColor = .sesacGreen
        bar.indicator.weight = .light
        //bar.backgroundView.tintColor = .white
        bar.backgroundView.style = .clear
        
        bar.buttons.customize { button in
            button.tintColor = .sesacGray6
            button.selectedTintColor = .sesacGreen
            button.font = .title4_R14!
            button.selectedFont = .title3_M14!
        }
        
        changeHobbyButton.fill(text: "취미 변경하기", radiusStatus: true)
        refreshButton.setImage(UIImage(named: "bt_refresh"), for: .normal)
        self.addSubview(buttonView)
        [changeHobbyButton, refreshButton].forEach { buttonView.addSubview($0) }
    }
    
    func constraints() {

        buttonView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(80)
        }
        
        changeHobbyButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
            make.height.equalTo(48)
            make.trailing.equalTo(refreshButton.snp.leading).offset(-8)
        }
        
        refreshButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
            make.size.equalTo(48)
        }
    }
}
