//
//  BirthViewController.swift
//  SeSAC_SLP
//
//  Created by 김지현 on 2022/01/20.
//

import UIKit
import RxGesture
import RxSwift
import Toast

class BirthViewController: UIViewController {
    
    var style: ToastStyle = {
        var style = ToastStyle()
        style.backgroundColor = .sesacGray3
        style.messageColor = .sesacBlack
        style.messageFont = .body4_R12!
        return style
    }()

    let mainView = SignupView(viewType: .birth)
    let viewModel = BirthViewModel()
    
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
        
        let input = BirthViewModel.Input(birthday: mainView.birthInputView.datePicker.rx.date, tap: mainView.button.rx.tap)
        let output = viewModel.transform(input: input)
        
        output.splitedBday
            .subscribe { splitedBday in
                self.mainView.birthInputView.yearTextField.text = splitedBday.element?[0]
                self.mainView.birthInputView.monthTextField.text = splitedBday.element?[1]
                self.mainView.birthInputView.dayTextField.text = splitedBday.element?[2]
            }
            .disposed(by: disposeBag)

        output.ageValidStatus
            .subscribe { valid in
                valid ? self.mainView.button.fill(text: "다음") : self.mainView.button.disable(text: "다음")
            }
            .disposed(by: disposeBag)
        
        output.sceneTransition
            .subscribe { _ in
                if self.viewModel.valid.value == true {
                    UserDefaults.birthday = self.mainView.birthInputView.datePicker.date.getBitrydayString()
                    UserDefaults.age = self.viewModel.age.value

                    self.navigationController?.pushViewController(EmailViewController(), animated: true)
                } else {
                    self.view.makeToast("새싹친구는 만 17세 이상만 사용할 수 있습니다", duration: 1.0, position: .center, style: self.style)
                }
            }
            .disposed(by: disposeBag)
    }

}
