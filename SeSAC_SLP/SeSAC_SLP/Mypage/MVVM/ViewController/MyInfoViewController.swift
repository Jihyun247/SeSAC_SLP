//
//  MyInfoViewController.swift
//  SeSAC_SLP
//
//  Created by 김지현 on 2022/01/28.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import RxGesture

class MyInfoViewController: UIViewController {
    
    // MARK: - 인스턴스
    let mainView = MyInfoView()
    let viewModel = MyInfoViewModel()
    
    let disposeBag = DisposeBag()
    
    // MARK: - loadView()
    override func loadView() {
        self.view = mainView
    }
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "내정보"
        //navigationItem.hidesBackButton = true
        navigationItem.backBarButtonItem = .basicBackButton(target: self)
        binding()
        // pop 되어 다시 돌아오면 아무것도 안뜸
    }
    
    // MARK: - 바인딩
    func binding() {
        
        self.mainView.profileView.rx.tapGesture()
            .when(.recognized)
            .subscribe { _ in
                self.navigationController?.pushViewController(MyProfileViewController(), animated: true)
            }
            .disposed(by: disposeBag)
        
        viewModel.setList()

        viewModel.myInfoCellList
            .asDriver(onErrorJustReturn: [])
            .drive(mainView.tableView.rx.items(cellIdentifier: MyInfoCell.identifier, cellType: MyInfoCell.self)) { (row, element, cell) in
                cell.iconImageView.image = element.iconImage
                cell.label.title2(text: element.labelText, textColor: .sesacBlack)
            }
            .disposed(by: disposeBag)
    }
}
