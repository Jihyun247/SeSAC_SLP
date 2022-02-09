//
//  MapView.swift
//  SeSAC_SLP
//
//  Created by 김지현 on 2022/02/07.
//

import Foundation
import UIKit
import MapKit

class MapView: UIView {
    let deviceWidthRatio = UIScreen.main.bounds.width / 375
    let deviceHeightRatio = UIScreen.main.bounds.height / 812
    
    let mapView = MKMapView()
    let centerMarkerImageView = UIImageView()
    let floatingButton = UIButton()
    let genderStackView = UIStackView()
    let allGenderButton = UIButton()
    let menGenderButton = UIButton()
    let womenGenderButton = UIButton()
    let currentLocationButton = UIButton()
    
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
        
        centerMarkerImageView.image = UIImage(named: "map_marker")
        
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
        
        genderStackView.axis = .vertical
        genderStackView.distribution = .fillEqually
        genderStackView.setShadowWithRadius(cornerRadius: 8)
        
        allGenderButton.fill(text: "전체", radiusStatus: true)
        allGenderButton.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        menGenderButton.inactive(text: "남자", radiusStatus: false)
        womenGenderButton.layer.borderWidth = 0
        menGenderButton.layer.maskedCorners = []
        
        womenGenderButton.inactive(text: "여자", radiusStatus: true)
        womenGenderButton.layer.borderWidth = 0
        womenGenderButton.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        currentLocationButton.setImage(UIImage(named: "place"), for: .normal)
        currentLocationButton.backgroundColor = .white
        currentLocationButton.setShadowWithRadius(cornerRadius: 8)
        
        [mapView, centerMarkerImageView, floatingButton, genderStackView, currentLocationButton].forEach { self.addSubview($0) }
        [allGenderButton, menGenderButton, womenGenderButton].forEach { genderStackView.addArrangedSubview($0) }
    }
    
    func constraints() {
        
        mapView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        
        centerMarkerImageView.snp.makeConstraints { make in
            make.center.equalTo(safeAreaLayoutGuide)
            make.size.equalTo(48)
        }
        
        floatingButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(safeAreaLayoutGuide).inset(16) // 차이점 한번 보기
            make.size.equalTo(64)
        }
        
        genderStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(144)
            make.width.equalTo(48)
        }
        
        allGenderButton.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        menGenderButton.snp.makeConstraints { make in
            make.top.equalTo(allGenderButton.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(womenGenderButton.snp.top)
        }
        
        womenGenderButton.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview()
        }
        
        currentLocationButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalTo(genderStackView.snp.bottom).offset(16)
            make.size.equalTo(48)
        }
        
        
    }
}
