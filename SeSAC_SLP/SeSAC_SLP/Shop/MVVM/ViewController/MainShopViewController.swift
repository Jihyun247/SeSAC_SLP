//
//  MainShopViewController.swift
//  SeSAC_SLP
//
//  Created by 김지현 on 2022/01/26.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import Toast

class ShopViewController: UIViewController {
    
    // MARK: - 인스턴스
    
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
        title = "새싹샵"
        navigationController?.initializeNavigationBarWithoutBackButton(navigationItem: self.navigationItem)
        binding()
    }
    
    // MARK: - 바인딩 (Tap , Button)
    func binding() {
    }
}
