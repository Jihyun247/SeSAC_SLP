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

// MARK: - lineheight
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
// MARK: - fonted label
extension UILabel {
    
    func onboard(text: String, textColor: UIColor) {
        self.text = text
        self.textColor = textColor
        self.font = .onboard_M24
        self.lineHeightRatio = 160
    }
    
    func display1(text: String, textColor: UIColor) {
        self.text = text
        self.textColor = textColor
        self.font = .display1_R20
        self.lineHeightRatio = 160
    }
    
    func title1(text: String, textColor: UIColor) {
        self.text = text
        self.textColor = textColor
        self.font = .title1_M16
        self.lineHeightRatio = 160
    }
    
    func title2(text: String, textColor: UIColor) {
        self.text = text
        self.textColor = textColor
        self.font = .title2_R16
        self.lineHeightRatio = 160
    }
    
    func title3(text: String, textColor: UIColor) {
        self.text = text
        self.textColor = textColor
        self.font = .title3_M14
        self.lineHeightRatio = 160
    }
    
    func title4(text: String, textColor: UIColor) {
        self.text = text
        self.textColor = textColor
        self.font = .title4_R14
        self.lineHeightRatio = 160
    }
    
    func title5(text: String, textColor: UIColor) {
        self.text = text
        self.textColor = textColor
        self.font = .title5_M12
        self.lineHeightRatio = 150
    }
    
    func body1(text: String, textColor: UIColor) {
        self.text = text
        self.textColor = textColor
        self.font = .body1_M16
        self.lineHeightRatio = 185
    }
    
    func body2(text: String, textColor: UIColor) {
        self.text = text
        self.textColor = textColor
        self.font = .body2_R16
        self.lineHeightRatio = 185
    }
    
    func body3(text: String, textColor: UIColor) {
        self.text = text
        self.textColor = textColor
        self.font = .body3_R14
        self.lineHeightRatio = 170
    }
    
    func body4(text: String, textColor: UIColor) {
        self.text = text
        self.textColor = textColor
        self.font = .body4_R12
        self.lineHeightRatio = 180
    }
    
    func caption(text: String, textColor: UIColor) {
        self.text = text
        self.textColor = textColor
        self.font = .caption_R10
        self.lineHeightRatio = 160
    }
    
    func highlight(searchText: String, color: UIColor = .sesacGreen) {
            guard let labelText = self.text else { return }
            do {
                let mutableString = NSMutableAttributedString(string: labelText)
                let regex = try NSRegularExpression(pattern: searchText, options: .caseInsensitive)
                
                for match in regex.matches(in: labelText, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSRange(location: 0, length: labelText.utf16.count)) as [NSTextCheckingResult] {
                    mutableString.addAttribute(.foregroundColor, value: color, range: match.range)
                }
                self.attributedText = mutableString
            } catch {
                print(error)
            }
        }
}
