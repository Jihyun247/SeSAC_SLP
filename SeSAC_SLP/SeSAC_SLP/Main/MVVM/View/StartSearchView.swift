//
//  StartSearchView.swift
//  SeSAC_SLP
//
//  Created by 김지현 on 2022/02/12.
//

import UIKit
import SnapKit

class StartSearchView: UIView {
    
    let deviceWidthRatio = UIScreen.main.bounds.width / 375
    let deviceHeightRatio = UIScreen.main.bounds.height / 812
    
    var searchBar =  UISearchBar()
    
    let otherHobbyLabel = UILabel()
    let myHobbyLabel = UILabel()

    let otherHobbyCollectionView: DynamicHeightCollectionView = {

        let layout = LeftAlignedCollectionViewFlowLayout()

        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)
        
        let cv = DynamicHeightCollectionView(frame: .zero, collectionViewLayout: layout)
        return cv
    }()
    let myHobbyCollectionView: DynamicHeightCollectionView = {

        let layout = LeftAlignedCollectionViewFlowLayout()

        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)
        let cv = DynamicHeightCollectionView(frame: .zero, collectionViewLayout: layout)

        return cv
    }()

    let startSearchButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        constraints()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        
        searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 70*deviceWidthRatio, height: 0))
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "띄어쓰기로 복수 입력이 가능해요", attributes: [NSAttributedString.Key.foregroundColor : UIColor.sesacGray6])
        searchBar.searchTextField.font = .title4_R14
        searchBar.searchTextField.textColor = .sesacBlack
        //searchBar.backgroundColor = .sesacGray1
        
        otherHobbyLabel.title6(text: "지금 주변에는", textColor: .sesacBlack)
        myHobbyLabel.title6(text: "내가 하고 싶은", textColor: .sesacBlack)
        
        otherHobbyCollectionView.backgroundColor = .clear
        myHobbyCollectionView.backgroundColor = .clear
        
        startSearchButton.fill(text: "새싹 찾기", radiusStatus: true)
        
        [otherHobbyLabel, myHobbyLabel, otherHobbyCollectionView, myHobbyCollectionView, startSearchButton].forEach { self.addSubview($0) }
    }
    
    func constraints() {
        
        otherHobbyLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(24)
            make.leading.equalToSuperview().offset(16)
        }
        
        otherHobbyCollectionView.snp.makeConstraints { make in
            make.top.equalTo(otherHobbyLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        myHobbyLabel.snp.makeConstraints { make in
            make.top.equalTo(otherHobbyCollectionView.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(16)
        }
        
        myHobbyCollectionView.snp.makeConstraints { make in
            make.top.equalTo(myHobbyLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        startSearchButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(48)
        }
        
    }
}
