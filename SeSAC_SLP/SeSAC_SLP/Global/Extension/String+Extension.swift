//
//  String+Extension.swift
//  SeSAC_SLP
//
//  Created by 김지현 on 2022/02/09.
//

import Foundation

extension String {
    
    func substring(from: Int, to: Int) -> String {
        
        if from >= count {
            return ""
        } else {
            let startIndex = index(startIndex, offsetBy: from)
            let endIndex = index(startIndex, offsetBy: to + 1)
                    
            return String(self[startIndex ..< endIndex])
        }
    }
}
