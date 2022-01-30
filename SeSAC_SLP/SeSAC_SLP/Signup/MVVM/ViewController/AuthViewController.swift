//
//  AuthViewController.swift
//  SeSAC_SLP
//
//  Created by 김지현 on 2022/01/20.
//

import Foundation

import UIKit
import RxGesture
import RxSwift
import RxCocoa
import Toast

class AuthViewController: UIViewController {
    
    // MARK: - 인스턴스
    var style: ToastStyle = {
        var style = ToastStyle()
        style.backgroundColor = .sesacGray3
        style.messageColor = .sesacBlack
        style.messageFont = .body4_R12!
        return style
    }()
    
    let mainView = SignupView(viewType: .auth)
    let viewModel = AuthViewModel()
    
    let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backBarButtonItem = .basicBackButton(target: self)
        self.view.makeToast("인증번호를 보냈습니다", duration: 1.0, position: .center, style: self.style)
        print(self.viewModel.verifyCode.value)
        binding()
    }
    
    func binding() {
        
        self.view.rx.tapGesture()
            .when(.recognized)
            .subscribe { _ in
                self.view.endEditing(true)
            }
            .disposed(by: disposeBag)
        
        let input = AuthViewModel.Input(inputCode: mainView.authInputView.textfield.rx.text, resendTap: mainView.authInputView.resendButton.rx.tap, nextTap: mainView.button.rx.tap)
        let output = viewModel.transform(input: input)
        
        output.codeValidStatus
            .subscribe { valid in
                valid ? self.mainView.button.fill(text: "인증하고 시작하기") : self.mainView.button.disable(text: "인증하고 시작하기")
            }
            .disposed(by: disposeBag)
        
        output.verifyCodeStart
            .subscribe { _ in
                // 버튼 활성화 안되어잇을때 토스트
                //if self.viewModel.
                self.viewModel.postVerifyCode(inputCode: self.mainView.authInputView.textfield.text ?? "")
            }
            .disposed(by: disposeBag)
        
        viewModel.postVerifyCodeResult
            .subscribe { result in
                switch result.element {
                case .success(_):
                    self.viewModel.getFirebaseToken()
                case .fail:
                    self.view.makeToast("전화번호 인증 실패", duration: 1.0, position: .center, style: self.style)
                case .none:
                    print("none")
                }
            }
            .disposed(by: disposeBag)
        
        viewModel.getFirebaseTokenResult
            .subscribe { result in
                switch result.element {
                case .success(_):
                    self.viewModel.login()
                case .fail:
                    self.view.makeToast("에러가 발생했습니다. 잠시 후 다시 시도해주세요", duration: 1.0, position: .center, style: self.style)
                case .none:
                    print("none")
                }
            }
            .disposed(by: disposeBag)
        
        viewModel.loginResult
            .subscribe { result in
                switch result.element {
                case .member:
                    print("뷰 전환 전")
                    DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                        let vc = TabBarController()
                        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {return}
                        windowScene.windows.first?.rootViewController = UINavigationController(rootViewController: vc)
                        windowScene.windows.first?.makeKeyAndVisible()
                    }
                case .notMember:
                    self.navigationController?.pushViewController(NicknameViewController(), animated: true)
                case .fail:
                    self.view.makeToast("에러가 발생했습니다. 잠시 후 다시 시도해주세요", duration: 1.0, position: .center, style: self.style)
                case .none:
                    print("none")
                }
            }
            .disposed(by: disposeBag)
        
        

        // 재전송 누를 시 다시 인증 문자 요청 함수 호출 !
//        self.mainView.authInputView.resendButton.rx.tap
//            .subscribe { text in
//
//                self.viewModel.getVerifyCode(number: self.viewModel.phoneNum.value) { result in
//
//                    switch result {
//                    case .success:
//                        self.mainView.authInputView.start(reset: true) // 타이머 리셋
//                        self.view.makeToast("메세지를 재전송 합니다.", duration: 1.0, position: .center, style: self.style)
//                        self.mainView.authInputView.textfield.text = ""
//
//                    case .error:
//                        self.view.makeToast("에러가 발생했습니다. 다시 시도해주세요", duration: 1.0, position: .center, style: self.style)
//
//                    case .overAccess:
//                        self.view.makeToast("과도한 인증 시도가 있었습니다. 나중에 다시 시도해 주세요", duration: 1.0, position: .center, style: self.style)
//                    }
//                }
//            }
//            .disposed(by: disposeBag)
    }

}
