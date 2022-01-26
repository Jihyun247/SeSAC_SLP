//
//  MypageViewController.swift
//  SeSAC_SLP
//
//  Created by 김지현 on 2022/01/26.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import Toast

class MypageViewController: UIViewController {
    
    // MARK: - 인스턴스
    var style: ToastStyle = {
        var style = ToastStyle()
        style.backgroundColor = .sesacGray3
        style.messageColor = .sesacBlack
        style.messageFont = .body4_R12!
        return style
    }()
    
//    let mainView = SignupView(viewType: .phonenum)
//    let viewModel = PhoneNumViewModel()
    
    let disposeBag = DisposeBag()
    
    // MARK: - loadView()
    override func loadView() {
        //self.view = mainView
    }
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        
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

    }
}
