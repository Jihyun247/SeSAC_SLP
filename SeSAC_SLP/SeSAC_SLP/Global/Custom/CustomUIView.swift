//
//  CustomUIView.swift
//  SeSAC_SLP
//
//  Created by 김지현 on 2022/02/22.
//

import UIKit

class SesacTitleButtonsView: UIView {
    
    let verticalStackView = UIStackView()
    let firstHorizontalStackView = UIStackView()
    let secondHorizontalStackView = UIStackView()
    let thirdHorizontalStackView = UIStackView()
    let mannerButton = InactiveButton()
    let timeButton = InactiveButton()
    let fastButton = InactiveButton()
    let kindButton = InactiveButton()
    let handyButton = InactiveButton()
    let beneficialButton = InactiveButton()
    let reputations = ["좋은 매너", "정확한 시간 약속", "빠른 응답", "친절한 성격", "능숙한 취미 실력", "유익한 시간"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        constraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        verticalStackView.axis = .vertical
        firstHorizontalStackView.axis = .horizontal
        secondHorizontalStackView.axis = .horizontal
        thirdHorizontalStackView.axis = .horizontal
        [verticalStackView, firstHorizontalStackView, secondHorizontalStackView, thirdHorizontalStackView].forEach {
            $0.spacing = 8
            $0.distribution = .fillEqually
        }
        for (index, button) in [mannerButton, timeButton, fastButton, kindButton, handyButton, beneficialButton].enumerated() {
            button.setTitle(reputations[index], for: .normal)
        }
        
        addSubview(verticalStackView)

        [mannerButton, timeButton].forEach { firstHorizontalStackView.addArrangedSubview($0) }
        [fastButton, kindButton].forEach { secondHorizontalStackView.addArrangedSubview($0) }
        [handyButton, beneficialButton].forEach { thirdHorizontalStackView.addArrangedSubview($0) }
        
        [firstHorizontalStackView, secondHorizontalStackView, thirdHorizontalStackView].forEach { verticalStackView.addArrangedSubview($0) }
    }
    
    func constraints() {
        
        self.snp.makeConstraints { make in
            make.height.equalTo(112)
        }
        
        verticalStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        [firstHorizontalStackView, secondHorizontalStackView, thirdHorizontalStackView, mannerButton, timeButton, fastButton, kindButton, handyButton, beneficialButton].forEach {
            $0.snp.makeConstraints { make in
                make.height.equalTo(32)
            }
        }
    }
}
