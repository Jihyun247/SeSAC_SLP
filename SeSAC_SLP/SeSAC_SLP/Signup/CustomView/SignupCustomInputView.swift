//
//  CustomViewWithTF.swift
//  SeSAC_SLP
//
//  Created by 김지현 on 2022/01/19.
//

import Foundation
import UIKit
import SnapKit

// MARK: - 회원가입 중간 input view custom

// 아직 언더라인
class AuthInputView: UIView {
    
    var limitTime: Int = 300
    var timer = Timer()
    
    let textfield = UnderlineTextField()
    let timeLabel = LineHeightLabel()
    let resendButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        constraints()
        start(reset: false)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
        constraints()
        start(reset: false)
    }
    
    func setup() {
        
        textfield.becomeFirstResponder()
        textfield.keyboardType = .numberPad
        textfield.textContentType = .oneTimeCode // SMS 왔을 시 code, passcode 단어 포함된 메시지 감지
        textfield.setBasic(placeholder: "인증번호 입력", leftPadding: 12)
        
        timeLabel.title3(text: "", textColor: .sesacGreen)
        
        resendButton.fill(text: "재전송")
        
        [textfield, timeLabel, resendButton].forEach { self.addSubview($0) }
    }
    
    func constraints() {
        
        textfield.snp.makeConstraints { make in
            make.leading.centerY.equalToSuperview()
            make.height.equalTo(48)
            
        }
        
        timeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(textfield.snp.centerY)
            make.trailing.equalTo(textfield.snp.trailing)
            make.size.equalTo(48)
        }
        
        resendButton.snp.makeConstraints { make in

            make.centerY.equalTo(textfield.snp.centerY)
            make.height.equalTo(40)
            make.width.equalTo(72)
            make.leading.equalTo(textfield.snp.trailing).offset(8)
            make.trailing.equalToSuperview()
        }
        
    }
    
    func start(reset: Bool) {

        timer.invalidate()
        reset ? limitTime = 300 : nil
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    @objc private func updateCounter() {
        
        if limitTime != 0 {
            let minute = (limitTime % 3600) / 60
            let second = (limitTime % 3600) % 60
            if second < 10 {
                timeLabel.text = "\(String(minute)):0\(String(second))"
            } else {
                timeLabel.text = "\(String(minute)):\(String(second))"
            }
            
            limitTime -= 1
            
        } else if limitTime == 0 {
            timer.invalidate()
            timeLabel.isHidden = true
        }
    }
}

// 언더라인 텍스트필드가 더 적절할듯
class BirthInputView: UIView {
    
    let stackView = UIStackView()
    
    let yearTextField = UnderlineTextField()
    let monthTextField = UnderlineTextField()
    let dayTextField = UnderlineTextField()
    
    let yearLabel = UILabel()
    let monthLabel = UILabel()
    let dayLabel = UILabel()
    
    let datePicker: UIDatePicker = {
        return UIDatePicker(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 216))
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        constraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
        constraints()
    }
    
    @objc func setDate() {
        self.endEditing(true)
    }
    
    func setup() {
        
        //[yearTextField, monthTextField, dayTextField].forEach { $0.keyboardType = .numberPad }
        
        yearTextField.becomeFirstResponder()
        
        [yearTextField, monthTextField, dayTextField].forEach {
            $0.setDatePicker(target: self, selector: #selector(setDate), datePicker: datePicker)
        }
        
        yearTextField.setBasic(placeholder: "1990", leftPadding: 12)
        monthTextField.setBasic(placeholder: "1", leftPadding: 12)
        dayTextField.setBasic(placeholder: "1", leftPadding: 12)
        
        yearLabel.title2(text: "년", textColor: .sesacBlack)
        monthLabel.title2(text: "월", textColor: .sesacBlack)
        dayLabel.title2(text: "일", textColor: .sesacBlack)
        
        [yearTextField, monthTextField, dayTextField, yearLabel, monthLabel, dayLabel].forEach { self.addSubview($0) }
    }
    
    func constraints() {
        
        yearTextField.snp.makeConstraints { make in
            make.leading.centerY.equalToSuperview()
            make.height.equalTo(48)
        }
        
        yearLabel.snp.makeConstraints { make in
            make.leading.equalTo(yearTextField.snp.trailing).offset(4)
            make.centerY.equalTo(yearTextField.snp.centerY)
        }
        
        monthTextField.snp.makeConstraints { make in
            make.leading.equalTo(yearLabel.snp.trailing).offset(23)
            make.centerY.equalTo(yearTextField.snp.centerY)
            make.height.equalTo(48)
            make.width.equalTo(yearTextField.snp.width)
        }
        
        monthLabel.snp.makeConstraints { make in
            make.leading.equalTo(monthTextField.snp.trailing).offset(4)
            make.centerY.equalTo(yearTextField.snp.centerY)
        }
        
        dayTextField.snp.makeConstraints { make in
            make.leading.equalTo(monthLabel.snp.trailing).offset(23)
            make.centerY.equalTo(yearTextField.snp.centerY)
            make.height.equalTo(48)
            make.width.equalTo(yearTextField.snp.width)
        }
        
        dayLabel.snp.makeConstraints { make in
            make.leading.equalTo(dayTextField.snp.trailing).offset(4)
            make.trailing.equalToSuperview()
            make.centerY.equalTo(yearTextField.snp.centerY)
        }
    }
}

class GenderInputView: UIView {
    
    let manButton = LabelUnderImgButton(image: UIImage(named: "man")!, title: "남자")
    let womanButton = LabelUnderImgButton(image: UIImage(named: "woman")!, title: "여자")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        constraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
        constraints()
    }
    
    private func setup() {
        
        manButton.imageView?.image = UIImage(named: "man")
        womanButton.imageView?.image = UIImage(named: "woman")
        
        manButton.titleLabel?.title2(text: "남자", textColor: .sesacBlack)
        womanButton.titleLabel?.title2(text: "여자", textColor: .sesacBlack)
        
        manButton.unpressed()
        womanButton.unpressed()
        
        [manButton, womanButton].forEach { self.addSubview($0) }
    }
    
    private func constraints() {
        
        manButton.snp.makeConstraints { make in
            make.bottom.top.equalToSuperview().inset(16)
            make.leading.equalToSuperview()
            make.width.equalTo(womanButton.snp.width)
        }
        
        womanButton.snp.makeConstraints { make in
            make.bottom.top.equalToSuperview().inset(16)
            make.trailing.equalToSuperview()
            make.leading.equalTo(manButton.snp.trailing).offset(12)
        }
    }
}


