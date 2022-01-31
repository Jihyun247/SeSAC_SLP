//
//  GenderViewController.swift
//  SeSAC_SLP
//
//  Created by 김지현 on 2022/01/20.
//

import UIKit
import RxGesture
import RxSwift

class GenderViewController: UIViewController {
    
    let mainView = SignupView(viewType: .gender)
    let viewModel = GenderViewModel()
    let httpViewModel = SignupHTTPViewModel()
    
    let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("fcmToken : \(UserDefaults.fcmToken)")
        navigationItem.backBarButtonItem = .basicBackButton(target: self)
        
        binding()
    }
    
    func binding() {
        
        self.view.rx.tapGesture()
            .when(.recognized)
            .subscribe { _ in
                self.view.endEditing(true)
            }
            .disposed(by: disposeBag)
        
        let input = GenderViewModel.Input(womanTap: mainView.genderInputView.womanButton.rx.tap, manTap: mainView.genderInputView.manButton.rx.tap, nextTap: mainView.button.rx.tap)
        let output = viewModel.transform(input: input)
        
        output.isWomanSelected
            .subscribe { selected in
                selected.element ?? false ? self.mainView.genderInputView.womanButton.pressed() : self.mainView.genderInputView.womanButton.unpressed()
            }
            .disposed(by: disposeBag)
        
        output.isManSelected
            .subscribe { selected in
                selected.element ?? false ? self.mainView.genderInputView.manButton.pressed() : self.mainView.genderInputView.manButton.unpressed()
            }
            .disposed(by: disposeBag)
        
        output.leastOneSelected
            .subscribe { bool in
                bool ? self.mainView.button.fill(text: "다음") : self.mainView.button.disable(text: "다음")
            }
            .disposed(by: disposeBag)
        
        output.sceneTransition
            .subscribe { _ in

                output.gender
                    .subscribe { UserDefaults.gender = $0.element?.rawValue ?? -1
                    }
                    .disposed(by: self.disposeBag)

                self.httpViewModel.signup()
            }
            .disposed(by: disposeBag)
        
        self.httpViewModel.signupResult
            .subscribe { result in
                switch result.element {
                case .success:
                    DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                        let vc = TabBarController()
                        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {return}
                        windowScene.windows.first?.rootViewController = UINavigationController(rootViewController: vc)
                        windowScene.windows.first?.makeKeyAndVisible()
                    }
                case .alreadyUser:
                    print("")
                case .cantUseNickname:
                    print("")
                case .fail:
                    print("")
                case .none:
                    print("")
                }
            }
            .disposed(by: disposeBag)
    }

}
