//
//  UINavigationBar+Extension.swift
//  SeSAC_SLP
//
//  Created by 김지현 on 2022/01/19.
//

import UIKit

extension UINavigationBar {
    
    func setTitle() {
        
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.sesacBlack, NSAttributedString.Key.font: UIFont.title3_M14]
        self.titleTextAttributes = attributes as [NSAttributedString.Key : Any]
    }

}
