//
//  CustomCardView.swift
//  SeSAC_SLP
//
//  Created by 김지현 on 2022/02/04.
//

import UIKit

class ProfileCardView: UIView {
    
    let deviceWidthRatio = UIScreen.main.bounds.width / 375
    let deviceHeightRatio = UIScreen.main.bounds.height / 812
    
    let sesacCardView = UIView()
    let backgroundImageView = UIImageView()
    let sesacImageView = UIImageView()
    
    let openableStackView = UIStackView()
    
    let nicknameView = UIView()
    let nicknameLabel = UILabel()
    let arrowButton = UIButton()
    
    let detailStackView = UIStackView()
    
    let sesacTitleView = UIView()
    let sesacTitleLabel = UILabel()
    let sesacTitleCollectionView = UICollectionView()
    
    let hobbyView = UIView()
    let hobbyLabel = UILabel()
    let hobbyCollectionView = UICollectionView()
    
    let reviewView = UIView()
    let reviewLabel = UILabel()
    let reviewWaitingLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        constraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        
        self.addSubview(sesacCardView)
        sesacCardView.addSubview(backgroundImageView)
        sesacCardView.addSubview(sesacImageView)
        
        self.addSubview(openableStackView)
        openableStackView.addArrangedSubview(nicknameView)
        openableStackView.addArrangedSubview(detailStackView)
        
        nicknameView.addSubview(nicknameLabel)
        nicknameView.addSubview(arrowButton)
        
        detailStackView.addArrangedSubview(sesacTitleView)
        detailStackView.addArrangedSubview(hobbyView)
        detailStackView.addArrangedSubview(reviewView)
        
        sesacTitleView.addSubview(sesacTitleLabel)
        sesacTitleView.addSubview(sesacTitleCollectionView)
        
        hobbyView.addSubview(hobbyLabel)
        hobbyView.addSubview(hobbyCollectionView)
        
        reviewView.addSubview(reviewLabel)
        reviewView.addSubview(reviewWaitingLabel)
    }
    
    func constraints() {
        
        sesacCardView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(backgroundImageView.snp.width).multipliedBy(0.56)
        }
        
        sesacImageView.snp.makeConstraints { make in
            make.size.equalTo(184)
            make.centerX.equalToSuperview()
        }
        
        openableStackView.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview()
        }
        
        nicknameView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(58)
        }
        
        detailStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        sesacTitleView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        sesacTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.leading.trailing.bottom.equalToSuperview().inset(16)
            make.height.equalTo(18)
        }
        
        sesacTitleCollectionView.snp.makeConstraints { make in
            make.top.equalTo(sesacTitleLabel.snp.bottom).offset(16)
            make.leading.trailing.bottom.equalToSuperview().inset(16)
        }
        
        hobbyView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        hobbyLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.leading.trailing.bottom.equalToSuperview().inset(16)
            make.height.equalTo(18)
        }
        
        hobbyCollectionView.snp.makeConstraints { make in
            make.top.equalTo(hobbyLabel.snp.bottom).offset(16)
            make.leading.trailing.bottom.equalToSuperview().inset(16)
        }
        
        reviewView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        reviewLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.leading.trailing.bottom.equalToSuperview().inset(16)
            make.height.equalTo(18)
        }
        
        reviewWaitingLabel.snp.makeConstraints { make in
            make.top.equalTo(reviewLabel.snp.bottom).offset(16)
            make.leading.trailing.bottom.equalToSuperview().inset(16)
            make.height.equalTo(24)
        }
        
        // 처음 초기화 세팅 하고 시뮬 돌려보기
    }
}
