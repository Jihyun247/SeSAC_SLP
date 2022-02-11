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
    
    let nearHobbyLabel = UILabel()
    let myHobbyLabel = UILabel()
    
    let nearHobbyCollectionView = UICollectionView()
    let myHobbyCollectionView = UICollectionView()
    
    let startSearchButton = UIButton()
    
    convenience init(status: MatchingStatus) {
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
    
    func setup(status: MatchingStatus? = nil) {

    }
    
    func constraints() {

    }
}
