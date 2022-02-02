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
        navigationController?.initializeNavigationBarWithoutBackButton(navigationItem: self.navigationItem)
        binding()
    }
    
    // MARK: - 바인딩
    func binding() {
        
        viewModel.mySimpleProfile
            .subscribe { simpleProfile in
                self.mainView.profileView.profileImageView.image = simpleProfile.element?.profileImage
                self.mainView.profileView.nicknameLabel.text = simpleProfile.element?.nickname
            }
            .disposed(by: disposeBag)
        
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
