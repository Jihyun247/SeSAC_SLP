//
//  MessageViewController.swift
//  SeSAC_SLP
//
//  Created by 김지현 on 2022/01/18.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import FirebaseAuth

class MessageViewController: UIViewController {
    
    let deviceHeightRatio = UIScreen.main.bounds.height / 896
    
    private var verifyCode: String?
    
    let phoneNumTextField = UITextField()
    let verifyCodeTextField = UITextField()

    let sendButton = UIButton()
    let doneButton = UIButton()
    
    var label = CustomLabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        constraints()
        Auth.auth().languageCode = "kr"
        
        sendButton.addTarget(self, action: #selector(sendButtonClicked), for: .touchUpInside)
        doneButton.addTarget(self, action: #selector(doneButtonClicked), for: .touchUpInside)
    }
    
    func setup() {

        
        
        label = .display1(text: "가나다라 가나다라 가나다라 가나다라 가나다라 ", textColor: .black)
        
        phoneNumTextField.placeholder = "휴대폰 전화번호"
        verifyCodeTextField.placeholder = "인증 번호"
        sendButton.setTitle("인증번호 받기", for: .normal)
        doneButton.setTitle("인증", for: .normal)
        
        sendButton.backgroundColor = .lightGray
        doneButton.backgroundColor = .lightGray
        
        // 커스텀 레이블 ,, add 마지막에 해주기
        [phoneNumTextField, verifyCodeTextField, sendButton, doneButton, label].forEach {
            self.view.addSubview($0)
        }

    }
    
    func constraints() {
        phoneNumTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(16)
            make.height.equalTo(45 * deviceHeightRatio)
        }
        
        verifyCodeTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalTo(phoneNumTextField.snp.bottom).offset(8)
            make.height.equalTo(45 * deviceHeightRatio)
        }
        
        sendButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalTo(doneButton.snp.top).offset(-20)
            make.height.equalTo(45 * deviceHeightRatio)

        }
        
        doneButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-30)
            make.height.equalTo(45 * deviceHeightRatio)
        }
        
        label.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(sendButton.snp.top).offset(-20)
            make.height.equalTo(100)
        }
    }
    
    @objc func sendButtonClicked() {
        
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumTextField.text ?? "", uiDelegate: nil) { verification, error in
            if error == nil {
                self.verifyCode = verification
            } else {
                print("Phone Verification Error: \(error!.localizedDescription) ")
            }
        }
    }
    
    @objc func doneButtonClicked() {
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verifyCode ?? "", verificationCode: verifyCodeTextField.text ?? "")
        
        Auth.auth().signIn(with: credential) { success, error in
            if error == nil {
                print(success ?? "")
                print("user signed in")
            } else {
                print(error.debugDescription)
            }
        }
    }
}
