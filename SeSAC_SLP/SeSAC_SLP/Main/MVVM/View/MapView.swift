//
//  MapView.swift
//  SeSAC_SLP
//
//  Created by 김지현 on 2022/02/07.
//

import Foundation
import UIKit
import MapKit

enum MatchingStatus {
    case general, waiting, matched
}

class MapView: UIView {
    let deviceWidthRatio = UIScreen.main.bounds.width / 375
    let deviceHeightRatio = UIScreen.main.bounds.height / 812
    
    let mapView = MKMapView()
    
    let floatingButton = UIButton()
    
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
        
        switch status {
        case .general:
            floatingButton.setImage(UIImage(named: "general_status_button"), for: .normal)
        case .waiting:
            floatingButton.setImage(UIImage(named: "waiting_status_button"), for: .normal)
        case .matched:
            floatingButton.setImage(UIImage(named: "matched_status_button"), for: .normal)
        case .none:
            print("none")
        }
        floatingButton.setCircleRadius(frameWidth: floatingButton.frame.width)
        [mapView, floatingButton].forEach { self.addSubview($0) }
    }
    
    func constraints() {
        
        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        floatingButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(safeAreaLayoutGuide).inset(16) // 차이점 한번 보기
            make.size.equalTo(64)
        }
        
    }
}
