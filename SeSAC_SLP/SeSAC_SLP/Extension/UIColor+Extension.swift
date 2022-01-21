//
//  UIColor+Extension.swift
//  SeSAC_SLP
//
//  Created by 김지현 on 2022/01/18.
//

import Foundation
import UIKit

extension UIColor {
    
    class var sesacBlack: UIColor { return UIColor(named: "Black") ?? .black}
    
    class var sesacGreen: UIColor { return UIColor(named: "Green") ?? .green}
    class var sesacWhiteGreen: UIColor { return UIColor(named: "WhiteGreen") ?? .green}
    class var sesacYellowGreen: UIColor { return UIColor(named: "YellowGreen") ?? .green}
    
    class var sesacGray1: UIColor { return UIColor(named: "Gray1") ?? .systemGray}
    class var sesacGray2: UIColor { return UIColor(named: "Gray2") ?? .systemGray2}
    class var sesacGray3: UIColor { return UIColor(named: "Gray3") ?? .systemGray3}
    class var sesacGray4: UIColor { return UIColor(named: "Gray4") ?? .systemGray4}
    class var sesacGray5: UIColor { return UIColor(named: "Gray5") ?? .systemGray5}
    class var sesacGray6: UIColor { return UIColor(named: "Gray6") ?? .systemGray6}
    class var sesacGray7: UIColor { return UIColor(named: "Gray7") ?? .gray}
    
    class var success: UIColor { return UIColor(named: "Success") ?? .blue}
    class var error: UIColor { return UIColor(named: "Error") ?? .red}
    class var focus: UIColor { return UIColor(named: "Focus") ?? .black}
}
