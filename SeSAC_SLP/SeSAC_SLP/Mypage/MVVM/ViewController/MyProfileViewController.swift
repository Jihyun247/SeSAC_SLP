//
//  MyProfileViewController.swift
//  SeSAC_SLP
//
//  Created by 김지현 on 2022/01/29.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import RxGesture

class MyProfileViewController: UIViewController {
    
    // MARK: - 인스턴스
    let mainView = MyProfileView()
    let viewModel = MyProfileViewModel()
    
    let disposeBag = DisposeBag()
    
    // MARK: - loadView()
    override func loadView() {
        self.view = mainView
    }
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "정보 관리"
        navigationController?.initializeNavigationBarWithBackButton(navigationItem: self.navigationItem)

        binding()
    }
    
    // MARK: - 바인딩
    func binding() {
    }

}
