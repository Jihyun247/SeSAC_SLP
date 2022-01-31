//
//  OnboardingCell.swift
//  SeSAC_SLP
//
//  Created by 김지현 on 2022/01/21.
//

import UIKit

class OnboardingCell: UICollectionViewCell {
    
    static let identifier = "OnboardingCell"
    
    let deviceWidthRatio = UIScreen.main.bounds.width / 375
    let deviceHeightRatio = UIScreen.main.bounds.height / 812
    
    var guideLabel = LineHeightLabel()
    let imageView = UIImageView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        contentView.backgroundColor = .white
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        setup(1)
        constraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(_ page: Int) {
        
        switch page {
        case 0:
            guideLabel.onboard(text: "위치 기반으로 빠르게 주위 친구를 확인", textColor: .sesacBlack)
            guideLabel.highlight(searchText: "위치 기반")
            imageView.image = UIImage(named: "onboarding_img1")
        case 1:
            guideLabel.onboard(text: "관심사가 같은 친구를 찾을 수 있어요", textColor: .sesacBlack)
            guideLabel.highlight(searchText: "관심사가 같은 친구")
            imageView.image = UIImage(named: "onboarding_img2")
        case 2:
            guideLabel.onboard(text: "SeSAC Friends", textColor: .sesacBlack)
            imageView.image = UIImage(named: "Social life-cuate")
        default:
            guideLabel.onboard(text: "위치 기반으로 빠르게 주위 친구를 확인", textColor: .sesacBlack)
            guideLabel.highlight(searchText: "위치 기반")
            imageView.image = UIImage(named: "onboarding_img1")
        }
        
        guideLabel.textAlignment = .center
        
        [guideLabel, imageView].forEach { self.contentView.addSubview($0) }
    }
    
    func constraints() {
        
        guideLabel.snp.makeConstraints { make in
            make.width.equalTo(230 * deviceWidthRatio)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(imageView.snp.top).offset(-(56 * deviceHeightRatio))
        }
        
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(360*deviceHeightRatio)
            make.bottom.equalToSuperview()
        }
    }
}
