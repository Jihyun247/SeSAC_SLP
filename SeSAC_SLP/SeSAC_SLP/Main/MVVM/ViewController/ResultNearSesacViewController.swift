//
//  ResultNearSesacViewController.swift
//  SeSAC_SLP
//
//  Created by 김지현 on 2022/02/20.
//

import UIKit
import RxSwift

class ResultNearSesacViewController: UIViewController {

    let mainView = ResultSesacView(status: .near)
    let viewModel = ResultSesacViewModel()
    let onqueueHttpViewModel = OnQueueHTTPViewModel()
    let resultHttpViewModel = ResultHttpViewModel()
    
    let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        binding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        onqueueHttpViewModel.onqueue(region: UserDefaults.region, lat: UserDefaults.lat, long: UserDefaults.long)
    }
    
    func binding() {
        
        let input = ResultSesacViewModel.Input(aroundQueue: onqueueHttpViewModel.exploreResult)
        let output = viewModel.transform(input: input)
        
        output.nearSesac.bind(to: mainView.sesacTableView.rx.items(cellIdentifier: ProfileCardTableViewCell.identifier, cellType: ProfileCardTableViewCell.self)) { (row, element, cell) in
            
            cell.backgroundImageView.image = UIImage(named: "sesac_background_\(element.background+1)")
            cell.sesacImageView.image = UIImage(named: "sesac_face_\(element.sesac+1)")
            cell.nicknameLabel.text = element.nick
            cell.arrowButton.rx.tap
                .subscribe { _ in
                    cell.isOpened = !cell.isOpened
                    if cell.isOpened {
                        cell.detailStackView.isHidden = false
                    } else {
                        cell.detailStackView.isHidden = true
                    }
                    self.mainView.sesacTableView.reloadData()
                }
                .disposed(by: cell.disposeBag)
        }
        .disposed(by: disposeBag)
        
        mainView.changeHobbyButton.rx.tap
            .subscribe { _ in
                self.resultHttpViewModel.deleteQueue()
                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(StartRequestViewController(), animated: true)
                }
            }
            .disposed(by: disposeBag)
        
        mainView.refreshButton.rx.tap
            .subscribe { _ in
                self.onqueueHttpViewModel.onqueue(region: UserDefaults.region, lat: UserDefaults.lat, long: UserDefaults.long)
            }
            .disposed(by: disposeBag)
    }
}
