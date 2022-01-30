//
//  SignupView.swift
//  SeSAC_SLP
//
//  Created by 김지현 on 2022/01/19.
//

import Foundation
import SnapKit
import UIKit

enum viewType {
case phonenum, auth, nickname, birth, email, gender
}

class SignupView: UIView {
    
    let deviceWidthRatio = UIScreen.main.bounds.width / 375
    let deviceHeightRatio = UIScreen.main.bounds.height / 812
    
    let stackView = UIStackView()
    let guideLabelView = UIView()
    let guideLabel = LineHeightLabel()
    let subGuideLabel = LineHeightLabel()
    
    let customView = UIView()
    lazy var textfield = TextFieldWithMsg()
    lazy var authInputView = AuthInputView()
    lazy var birthInputView = BirthInputView()
    lazy var genderInputView = GenderInputView()
    
    let button = UIButton()
    
    convenience init(viewType: viewType) {
        self.init(frame: .zero)
        
        setup(viewType: viewType)
        constraints()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(viewType: viewType? = nil) {
        
        switch viewType {
        case .phonenum:
            self.guideLabel.display1(text: "새싹 서비스 이용을 위해    휴대폰 번호를 입력해 주세요", textColor: .sesacBlack)
            self.subGuideLabel.isHidden = true
            
            self.textfield.keyboardType = .numberPad
            self.textfield.setBasic(placeholder: "휴대폰 번호 (- 없이 숫자만 입력)", leftPadding: 12)
            self.customView.addSubview(textfield)
            self.textfield.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.leading.trailing.equalToSuperview()
                make.height.equalTo(48)
            }
            self.button.disable(text: "인증 문자 받기")
            
        case .auth:
            self.guideLabel.display1(text: "인증번호가 문자로 전송되었어요", textColor: .sesacBlack)
            self.subGuideLabel.isHidden = false
            self.subGuideLabel.title2(text: "(최대 소모 20초)", textColor: .sesacGray7)
            
            self.customView.addSubview(authInputView)
            authInputView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            
        case .nickname:
            self.guideLabel.display1(text: "닉네임을 입력해 주세요", textColor: .sesacBlack)
            self.subGuideLabel.isHidden = true
            
            self.textfield.setBasic(placeholder: "10자 이내로 입력", leftPadding: 12)
            self.customView.addSubview(textfield)
            self.textfield.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.leading.trailing.equalToSuperview()
                make.height.equalTo(48)
            }
            
        case .birth:
            self.guideLabel.display1(text: "생년월일을 알려주세요", textColor: .sesacBlack)
            self.subGuideLabel.isHidden = true
            
            self.customView.addSubview(birthInputView)
            birthInputView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            
        case .email:
            self.guideLabel.display1(text: "이메일을 입력해 주세요", textColor: .sesacBlack)
            self.subGuideLabel.isHidden = false
            self.subGuideLabel.title2(text: "휴대폰 번호 변경 시 인증을 위해 사용해요", textColor: .sesacGray7)
            
            self.textfield.setBasic(placeholder: "SeSAC@email.com", leftPadding: 12)
            self.customView.addSubview(textfield)
            self.textfield.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.leading.trailing.equalToSuperview()
                make.height.equalTo(48)
            }
            
        case .gender:
            self.guideLabel.display1(text: "성별을 선택해 주세요", textColor: .sesacBlack)
            self.subGuideLabel.isHidden = false
            self.subGuideLabel.title2(text: "새싹 찾기 기능을 이용하기 위해서 필요해요!", textColor: .sesacGray7)
            
            self.customView.addSubview(genderInputView)
            genderInputView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }

        default:
            print("none")
        }
        
        self.backgroundColor = .white
        
        textfield.becomeFirstResponder()
        
        guideLabel.textAlignment = .center
        subGuideLabel.textAlignment = .center
        
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        
        [guideLabelView, subGuideLabel].forEach { stackView.addArrangedSubview($0) }
        guideLabelView.addSubview(guideLabel)
        [stackView, customView, button].forEach { self.addSubview($0) }
        
    }
    
    func constraints() {
        
        stackView.snp.makeConstraints { make in
            make.width.equalTo(300*deviceWidthRatio)
            make.centerX.equalToSuperview()
            make.height.equalTo(80)
            make.centerY.equalToSuperview().multipliedBy(0.5 * deviceHeightRatio)
        }
        
        guideLabelView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
        }
        guideLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
        }
        subGuideLabel.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(guideLabelView.snp.bottom)
        }
        
        customView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(152)
            make.top.equalTo(stackView.snp.bottom).offset((16 * deviceHeightRatio))
        }
        
        button.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(48)
            make.top.equalTo(customView.snp.bottom).offset((16 * deviceHeightRatio))
        }
    }
}

