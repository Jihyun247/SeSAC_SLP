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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    } 
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        
        bar.layout.transitionStyle = .snap
        bar.layout.contentMode = .fit
        bar.indicator.tintColor = .sesacGreen
        bar.indicator.weight = .light
        bar.backgroundView.style = .flat(color: .white)
        
        bar.buttons.customize { button in
            button.tintColor = .sesacGray6
            button.selectedTintColor = .sesacGreen
            button.font = .title4_R14!
            button.selectedFont = .title3_M14!
        }
    }
}
