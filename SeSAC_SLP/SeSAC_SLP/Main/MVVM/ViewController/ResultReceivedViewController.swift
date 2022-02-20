//
//  ResultReceivedViewController.swift
//  SeSAC_SLP
//
//  Created by 김지현 on 2022/02/20.
//

import UIKit
import RxSwift

class ResultReceivedViewController: UIViewController {
    
    let mainView = ResultSesacView(status: .received)
    let viewModel = ResultSesacViewModel()
    let onqueueHttpViewModel = OnQueueHTTPViewModel()
    
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
        
    }
}
