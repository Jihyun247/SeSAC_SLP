//
//  Int+Extension.swift
//  SeSAC_SLP
//
//  Created by 김지현 on 2022/02/09.
//

import UIKit

extension Int {
    static func calculateRegion(lat: Double, long: Double) -> Int {
        
        let calculatedLat = String(lat + 90).components(separatedBy: ["."]).joined()
        let calculatedLong = String(long + 180).components(separatedBy: ["."]).joined()
        
        let stringRegion = calculatedLat.substring(from: 0, to: 4) + calculatedLong.substring(from: 0, to: 4)
        
        return Int(stringRegion) ?? 0
    }
}
