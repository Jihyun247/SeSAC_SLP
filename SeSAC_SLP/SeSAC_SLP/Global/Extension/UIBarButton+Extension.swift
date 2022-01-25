//
//  UIBarButton+Extension.swift
//  SeSAC_SLP
//
//  Created by 김지현 on 2022/01/19.
//

import UIKit
import SnapKit

extension UIBarButtonItem {
    
    
    
    class func basicBackButton(target: UIViewController) -> UIBarButtonItem? {
        
        let backBarButtonItem = UIBarButtonItem(image: UIImage(named: "arrow"), style: .done, target: target, action: nil)
        backBarButtonItem.tintColor = .sesacBlack
        return backBarButtonItem
    }
    
    
    class func basicAddButton(target: UIViewController) -> UIBarButtonItem? {

        
        let basicAddButtonItem = UIBarButtonItem(image: UIImage(named: "plus"), style: .plain, target: target, action: nil)
        basicAddButtonItem.tintColor = .sesacBlack
        
        return basicAddButtonItem
    }
}
