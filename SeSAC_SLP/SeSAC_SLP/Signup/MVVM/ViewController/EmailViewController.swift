//
//  EmailViewController.swift
//  SeSAC_SLP
//
//  Created by 김지현 on 2022/01/20.
//

import UIKit
import RxGesture
import RxSwift
import Toast

class EmailViewController: UIViewController {
    
    var style: ToastStyle = {
        var style = ToastStyle()
        style.backgroundColor = .sesacGray3
        style.messageColor = .sesacBlack
        style.messageFont = .body4_R12!
        return style
    }()
    
    let mainView = SignupView(viewType: .email)
    let viewModel = EmailViewModel()
    
    let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.initializeNavigationBarWithBackButton(navigationItem: self.navigationItem)
        binding()
    }
    
    func binding() {
        
        self.view.rx.tapGesture()
            .when(.recognized)
            .subscribe { _ in
                self.view.endEditing(true)
            }
            .disposed(by: disposeBag)
        
        let input = EmailViewModel.Input(email: mainView.textfield.rx.text, tap: mainView.button.rx.tap)
        let output = viewModel.transform(input: input)
        
        output.emailValidStatus
            .subscribe { status in
                if let valid = status.element, valid {
                    self.mainView.textfield.errorMessage = ""
                    self.mainView.button.fill(text: "다음")
                    
                }  else {
                    self.mainView.textfield.text == "" ? nil : self.mainView.textfield.setError(text: "이메일 형식이 올바르지 않습니다")
                    self.mainView.button.disable(text: "다음")
                }
            }
            .disposed(by: disposeBag)
        
        output.emailValidStatus
            .bind(to: mainView.button.rx.isEnabled)
            .disposed(by: disposeBag)
        
        output.sceneTransition
            .subscribe { _ in
                UserDefaults.email = self.mainView.textfield.text ?? ""
                self.navigationController?.pushViewController(GenderViewController(), animated: true)
            }
            .disposed(by: disposeBag)
    }
}
