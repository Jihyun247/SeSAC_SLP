//
//  CustomCardView.swift
//  SeSAC_SLP
//
//  Created by 김지현 on 2022/02/04.
//

import UIKit
import RxSwift

class ProfileCardTableViewCell: UITableViewCell {
    
    static let identifier = "ProfileCardTableViewCell"
    
    var disposeBag = DisposeBag()
    var isOpened: Bool = false
    var hobbyData = PublishSubject<[String]>()
    
    let deviceWidthRatio = UIScreen.main.bounds.width / 375
    let deviceHeightRatio = UIScreen.main.bounds.height / 812
    
    let sesacCardView = UIView()
    let backgroundImageView = UIImageView()
    let sesacImageView = UIImageView()
    let matchingButton = UIButton()
    
    let openableStackView = UIStackView()
    
    let nicknameView = UIView()
    let nicknameLabel = UILabel()
    let arrowButton = UIButton()
    
    let detailStackView = UIStackView()
    
    let sesacTitleView = UIView()
    let sesacTitleLabel = UILabel()
    let sesacTitleCollectionView = SesacTitleButtonsView()
    
    let hobbyView = UIView()
    let hobbyLabel = UILabel()
    let hobbyCollectionView: DynamicHeightCollectionView = {
        
        let layout = LeftAlignedCollectionViewFlowLayout()
        
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)
        
        let cv = DynamicHeightCollectionView(frame: .zero, collectionViewLayout: layout)
        return cv
    }()
    
    let reviewView = UIView()
    let reviewLabel = UILabel()
    let reviewArrowImageView = UIImageView()
    let latestReviewLabel = UILabel()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        disposeBag = DisposeBag()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(status: ResultViewType, hobby: [String]) {
        
        layoutIfNeeded()
        selectionStyle = .none
        
        backgroundImageView.image = UIImage(named: "sesac_background_1")
        backgroundImageView.setBorderColorAndRadius(cornerRadius: 8.0)
        
        sesacImageView.image = UIImage(named: "sesac_face_1")
        
        status == .near ? matchingButton.requestMatching() : matchingButton.receiveMatching()
        
        contentView.addSubview(sesacCardView)
        [backgroundImageView, sesacImageView, matchingButton].forEach { sesacCardView.addSubview($0) }
        
        openableStackView.setBorderColorAndRadius(borderColor: .sesacGray2, borderWidth: 1, cornerRadius: 8.0)
        
        openableStackView.axis = .vertical
        //openableStackView.alignment = .fill
        openableStackView.distribution = .fillProportionally
        
        if isOpened {
            detailStackView.isHidden = false
        } else {
            detailStackView.isHidden = true
        }
        
        contentView.addSubview(openableStackView)
        [nicknameView, detailStackView].forEach { openableStackView.addArrangedSubview($0) }
        
        nicknameLabel.title1(text: "사또밥", textColor: .sesacBlack)
        arrowButton.setImage(UIImage(named: "downside_arrow"), for: .normal)
        
        [nicknameLabel, arrowButton].forEach { nicknameView.addSubview($0) }
        
        sesacTitleLabel.title6(text: "새싹 타이틀", textColor: .sesacBlack)
        hobbyLabel.title6(text: "하고 싶은 취미", textColor: .sesacBlack)
        reviewLabel.title6(text: "새싹 리뷰", textColor: .sesacBlack)
        latestReviewLabel.body3(text: "첫 리뷰를 기다리는 중이에요!", textColor: .sesacGray6)
        
        hobbyData.onNext(hobby)
        hobbyCollectionView.register(HobbyCollectionViewCell.self, forCellWithReuseIdentifier: HobbyCollectionViewCell.identifier)
        hobbyData.bind(to: hobbyCollectionView.rx.items(cellIdentifier: HobbyCollectionViewCell.identifier, cellType: HobbyCollectionViewCell.self)) { (row, element, cell) in
            // 취미 셀 안뜸
            cell.setup(hobbyType: .otherHobby)
            cell.hobbyButton.setTitle(element, for: .normal)
            cell.hobbyButton.isEnabled = false
        }
        .disposed(by: disposeBag)
        
        detailStackView.axis = .vertical
        //detailStackView.alignment = .fill
        detailStackView.distribution = .fillProportionally
        
        [sesacTitleView, hobbyView, reviewView].forEach { detailStackView.addArrangedSubview($0) }
        [sesacTitleLabel, sesacTitleCollectionView].forEach { sesacTitleView.addSubview($0) }
        [hobbyLabel, hobbyCollectionView].forEach { hobbyView.addSubview($0) }
        [reviewLabel, reviewArrowImageView, latestReviewLabel].forEach { reviewView.addSubview($0) }
        
        constraints()
    }
    
    func constraints() {
        
        sesacCardView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(16)
            make.height.greaterThanOrEqualTo(194)
        }
        
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        sesacImageView.snp.makeConstraints { make in
            make.size.equalTo(184)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(1.2)
        }
        
        matchingButton.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(16)
            make.height.equalTo(40)
            make.width.equalTo(80)
        }
        
        openableStackView.snp.makeConstraints { make in
            make.top.equalTo(sesacCardView.snp.bottom)
            make.bottom.leading.trailing.equalToSuperview().inset(16)
            //make.height.greaterThanOrEqualTo(300)
        }
        
        nicknameView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(58)
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
        }
        
        arrowButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(16)
        }
        
        detailStackView.snp.makeConstraints { make in
            make.top.equalTo(nicknameView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        sesacTitleView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        sesacTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(18)
        }
        
        sesacTitleCollectionView.snp.makeConstraints { make in
            make.top.equalTo(sesacTitleLabel.snp.bottom).offset(16)
            make.leading.trailing.bottom.equalToSuperview().inset(16)
            make.height.equalTo(112)
        }
        
        hobbyView.snp.makeConstraints { make in
            make.top.equalTo(sesacTitleView.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
        
        hobbyLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(18)
        }
        
        hobbyCollectionView.snp.makeConstraints { make in
            make.top.equalTo(hobbyLabel.snp.bottom).offset(16)
            make.leading.trailing.bottom.equalToSuperview().inset(16)
        }
        
        reviewView.snp.makeConstraints { make in
            make.top.equalTo(hobbyView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        reviewLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(18)
        }
        
        reviewArrowImageView.snp.makeConstraints { make in
            make.centerY.equalTo(reviewLabel.snp.centerY)
            make.size.equalTo(16)
            make.trailing.equalToSuperview().inset(16)
        }
        
        latestReviewLabel.snp.makeConstraints { make in
            make.top.equalTo(reviewLabel.snp.bottom).offset(16)
            make.leading.trailing.bottom.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
    }
}
