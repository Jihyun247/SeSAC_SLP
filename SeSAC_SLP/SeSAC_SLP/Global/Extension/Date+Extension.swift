//
//  Date+Extension.swift
//  SeSAC_SLP
//
//  Created by 김지현 on 2022/01/24.
//

import Foundation

extension Date {
    
    func splitDate() -> [String] {
        
        let df = DateFormatter()
        df.dateFormat = "yyyy"
        let year: String = df.string(from: self)
        df.dateFormat = "MM"
        let month: String = df.string(from: self)
        df.dateFormat = "dd"
        let day: String = df.string(from: self)
        
        return [year, month, day]
    }
    
    func getBitrydayString() -> String {
        
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        return df.string(from: self)
    }
    
    func getAge() -> Int {
        let gregorian = NSCalendar(identifier: NSCalendar.Identifier.gregorian)
        let age = gregorian?.components([.month, .day, .year], from: self, to: Date()).year
        return age ?? 0
    }
}
