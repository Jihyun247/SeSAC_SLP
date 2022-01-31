//
//  PhoneNumViewController.swift
//  SeSAC_SLP
//
//  Created by 김지현 on 2022/01/19.
//

import UIKit
import RxGesture
import RxSwift
import Toast
import FirebaseAuth

class PhoneNumViewController: UIViewController {
    
    // MARK: - 인스턴스
    var style: ToastStyle = {
        var style = ToastStyle()
        style.backgroundColor = .sesacGray3
        style.messageColor = .sesacBlack
        style.messageFont = .body4_R12!
        return style
    }()
    
    let mainView = SignupView(viewType: .phonenum)
    let viewModel = PhoneNumViewModel()
    let httpViewModel = SignupHTTPViewModel()
    
    let disposeBag = DisposeBag()
    
    // MARK: - loadView()
    override func loadView() {
        self.view = mainView
    }
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.textfield.delegate = self
        navigationItem.hidesBackButton = true
        navigationItem.backBarButtonItem = .basicBackButton(target: self)
        binding()
    }
    
    // MARK: - 바인딩 (Tap , Button)
    func binding() {
        
        self.view.rx.tapGesture()
            .when(.recognized)
            .subscribe { _ in
                self.view.endEditing(true)
            }
            .disposed(by: disposeBag)

        self.mainView.button.rx.tap
            .subscribe { _ in
                
                self.httpViewModel.getVerifyCode(number: self.mainView.textfield.text ?? "") { result in

                    switch result {
                    case .success:
                        let vc = AuthViewController()
                        vc.httpViewModel.verifyCode.accept(self.viewModel.verifyCode.value)
                        vc.viewModel.phoneNum.accept(self.mainView.textfield.text ?? "")
                        self.navigationController?.pushViewController(vc, animated: true)
                        
                    case .error:
                        self.view.makeToast("에러가 발생했습니다. 다시 시도해주세요", duration: 1.0, position: .center, style: self.style)
                        
                    case .overAccess:
                        self.view.makeToast("과도한 인증 시도가 있었습니다. 나중에 다시 시도해 주세요", duration: 1.0, position: .center, style: self.style)
                    }
                }
            }
            .disposed(by: disposeBag)

    }
}

// MARK: - UITextFieldDelegate
extension PhoneNumViewController: UITextFieldDelegate {
    
    // RX + tf delegate 함께 쓰는 이유
    // 원하는 경우 UITextField 대리인 https://developer.apple.com/documentation/uikit/uitextfielddelegate/1619599-textfield?language=objc 을 구현해야 합니다. 이것이 더 올바른 옵션입니다. 물론 VM 내부의 텍스트를 포맷하여 textField에 제공할 수 있지만 중간에 있는 값을 편집하려면 커서에 문제가 있습니다.
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        textField.formatPhoneNumber(range: range, string: string)
        
        let input = PhoneNumViewModel.Input(phoneNum: mainView.textfield.rx.text)
        let output = viewModel.transform(input: input)
        
        output.numValidStatus
            .bind(to: mainView.button.rx.isEnabled)
            .disposed(by: disposeBag)
        
        output.numValidStatus
            .subscribe { status in
                
                if let valid = status.element, valid {
                    self.mainView.textfield.errorMessage = "" // 그냥 "" 하면 에러 없어짐
                    self.mainView.button.fill(text: "인증 문자 받기")
                }  else {
                    self.mainView.textfield.text!.count < 13 ? self.mainView.textfield.errorMessage = "" : self.mainView.textfield.setError(text: "잘못된 전화번호 형식입니다")
                    self.mainView.button.disable(text: "인증 문자 받기")
                }
            }
            .disposed(by: disposeBag)
        
        // 와 이거 때문에 진짜 몇시간 버림 false 되면 Rx가 작동을 안함
        return false
    }
    
    // 그래서 Rx + tx delegate 함께 쓸 시 이 함수 꼭필요
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}
