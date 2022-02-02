//
//  CustomTabBar.swift
//  SeSAC_SLP
//
//  Created by 김지현 on 2022/02/02.
//

import UIKit

class HeightCustomTabBarController: UITabBarController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        object_setClass(self.tabBar, HeightCustomTabBar.self)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    class HeightCustomTabBar: UITabBar {
        
        override func sizeThatFits(_ size: CGSize) -> CGSize {
            
            var sizeThatFits = super.sizeThatFits(size)
            
            sizeThatFits.height = 56
            // label offset 변경하는 방법 없을까
            return sizeThatFits
            
        }
        
    }
    
}
