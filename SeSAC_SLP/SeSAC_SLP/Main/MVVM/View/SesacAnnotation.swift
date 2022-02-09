//
//  SesacAnnotation.swift
//  SeSAC_SLP
//
//  Created by 김지현 on 2022/02/10.
//

import Foundation
import MapKit

class SesacAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    let sesacType: SesacType

    init(coordinate: CLLocationCoordinate2D, sesacType: SesacType) {
        self.coordinate = coordinate
        self.sesacType = sesacType
        super.init()
    }
}

class SesacAnnotationView: MKAnnotationView {
    
    static let identifier = "SesacAnnotationView"
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        frame = CGRect(x: 0, y: 0, width: 48, height: 48)
        centerOffset = CGPoint(x: 0, y: -(frame.size.height/2))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
