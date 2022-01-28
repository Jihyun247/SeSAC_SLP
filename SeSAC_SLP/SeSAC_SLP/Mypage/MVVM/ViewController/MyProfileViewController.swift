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
    //let mainView = MyInfoView()
    //let viewModel = MyInfoViewModel()
    
    let disposeBag = DisposeBag()
    
    // MARK: - loadView()
    override func loadView() {
        //self.view = mainView
    }
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "정보 관리"
        //navigationItem.hidesBackButton = true
        navigationItem.backBarButtonItem = .basicBackButton(target: self)
        binding()
    }
    
    // MARK: - 바인딩
    func binding() {
    }

}