//
//  UILabel+Extension.swift
//  SeSAC_SLP
//
//  Created by 김지현 on 2022/01/18.
//

import Foundation
import UIKit

public protocol TypographyExtensions: UILabel {
    var lineHeightRatio: CGFloat? {get set}
}

extension UILabel: TypographyExtensions {
    
    fileprivate var attributes: [NSAttributedString.Key: Any]? {
        get {
            if let attributedText = attributedText {
                return attributedText.attributes(at: 0, effectiveRange: nil)
            } else {
                return nil
            }
        }
    }
    
    fileprivate func getAttribute<AttributeType>(_ key: NSAttributedString.Key) -> AttributeType? {
        return attributes?[key] as? AttributeType
    }
    
    var paragraphStyle: NSParagraphStyle? {
        getAttribute(.paragraphStyle)
    }
    
    public var lineHeightRatio: CGFloat? {
        get {
            paragraphStyle?.maximumLineHeight
        }
        set {
            let lineHeightRatio = (newValue ?? 100) / 100
            // font.lineheight 찍어보니 폰트 사이즈에 기본 144% 정도를 차지하는 것 같다.
            let lineHeight = lineHeightRatio * (font.lineHeight / 1.44)
            let baselineOffset = (lineHeight - font.lineHeight) / 4.0
            
            let mutableParagraphStyle = NSMutableParagraphStyle()
            mutableParagraphStyle.lineBreakStrategy = .hangulWordPriority
            mutableParagraphStyle.minimumLineHeight = lineHeight
            mutableParagraphStyle.maximumLineHeight = lineHeight
            
            attributedText = NSAttributedString(string: text ?? "", attributes: [
                .baselineOffset: baselineOffset,
                .paragraphStyle: mutableParagraphStyle
            ])
        }
    }
}

extension UILabel {
    
    class func display1(text: String, textColor: UIColor) -> LineHeightLabel {
        return LineHeightLabel(text: text, textColor: textColor, font: .display1_R20!, lineHeightRatio: 160)
    }
    
    class func title1(text: String, textColor: UIColor) -> LineHeightLabel {
        return LineHeightLabel(text: text, textColor: textColor, font: .title1_M16!, lineHeightRatio: 160)
    }
    
    class func title2(text: String, textColor: UIColor) -> LineHeightLabel {
        return LineHeightLabel(text: text, textColor: textColor, font: .title2_R16!, lineHeightRatio: 160)
    }
    
    class func title3(text: String, textColor: UIColor) -> LineHeightLabel {
        return LineHeightLabel(text: text, textColor: textColor, font: .title3_M14!, lineHeightRatio: 160)
    }
    
    class func title4(text: String, textColor: UIColor) -> LineHeightLabel {
        return LineHeightLabel(text: text, textColor: textColor, font: .title4_R14!, lineHeightRatio: 160)
    }
    
    class func title5(text: String, textColor: UIColor) -> LineHeightLabel {
        return LineHeightLabel(text: text, textColor: textColor, font: .title5_M12!, lineHeightRatio: 150)
    }
    
    class func body1(text: String, textColor: UIColor) -> LineHeightLabel {
        return LineHeightLabel(text: text, textColor: textColor, font: .body1_M16!, lineHeightRatio: 185)
    }
    
    class func body2(text: String, textColor: UIColor) -> LineHeightLabel {
        return LineHeightLabel(text: text, textColor: textColor, font: .body2_R16!, lineHeightRatio: 185)
    }
    
    class func body3(text: String, textColor: UIColor) -> LineHeightLabel {
        return LineHeightLabel(text: text, textColor: textColor, font: .body3_R14!, lineHeightRatio: 170)
    }
    
    class func body4(text: String, textColor: UIColor) -> LineHeightLabel {
        return LineHeightLabel(text: text, textColor: textColor, font: .body4_R12!, lineHeightRatio: 180)
    }
    
    class func caption(text: String, textColor: UIColor) -> LineHeightLabel {
        return LineHeightLabel(text: text, textColor: textColor, font: .caption_R10!, lineHeightRatio: 160)
    }
}
