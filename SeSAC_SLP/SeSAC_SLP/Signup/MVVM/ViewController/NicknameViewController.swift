//
//  NicknameViewController.swift
//  SeSAC_SLP
//
//  Created by 김지현 on 2022/01/20.
//

import UIKit
import RxGesture
import RxSwift
import RxCocoa
import Toast

class NicknameViewController: UIViewController {
    
    let mainView = SignupView(viewType: .nickname)
    let viewModel = NicknameViewModel()
    
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
        
        // TapGesture
        self.view.rx.tapGesture()
            .when(.recognized)
            .subscribe { _ in
                self.view.endEditing(true)
            }
            .disposed(by: disposeBag)
        
        let input = NicknameViewModel.Input(nickname: mainView.textfield.rx.text, tap: mainView.button.rx.tap)
        let output = viewModel.transform(input: input)
        
        output.nickValidStatus
            .subscribe { status in
                if let valid = status.element, valid {
                    self.mainView.textfield.errorMessage = "" // 그냥 "" 하면 에러 없어짐
                    self.mainView.button.fill(text: "다음")
                    
                }  else {
                    self.mainView.textfield.text == "" ? nil : self.mainView.textfield.setError(text: "10자 이내로 설정해주세요")
                    self.mainView.button.disable(text: "다음")
                }
            }
            .disposed(by: disposeBag)
        
        output.nickValidStatus
            .bind(to: mainView.button.rx.isEnabled)
            .disposed(by: disposeBag)
        
        output.sceneTransition
            .subscribe { _ in
                UserDefaults.nickname = self.mainView.textfield.text ?? ""
                self.navigationController?.pushViewController(BirthViewController(), animated: true)
            }
            .disposed(by: disposeBag)
    }
}
