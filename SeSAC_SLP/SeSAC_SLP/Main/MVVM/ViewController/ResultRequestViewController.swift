//
//  ResultRequestViewController.swift
//  SeSAC_SLP
//
//  Created by 김지현 on 2022/02/11.
//

import UIKit
import RxSwift
import RxGesture
import Toast
import Tabman
import Pageboy

class ResultRequestViewController: TabmanViewController {
    
    private let viewControllers = [ResultNearSesacViewController(), ResultReceivedSesacViewController()]
    private let titleList = ["주변 새싹", "받은 요청"]
    
    var timer: Timer?
    var style: ToastStyle = {
        var style = ToastStyle()
        style.backgroundColor = .sesacGray3
        style.messageColor = .sesacBlack
        style.messageFont = .body4_R12!
        return style
    }()
    
    let mainView = ResultRequestView()
    let viewModel = ResultRequestViewModel()
    
    let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "새싹 찾기"
        navigationController?.navigationBarWithRightItem(navigationItem: self.navigationItem, title: "찾기중단", action: #selector(stopRequestButtonClicked))
        setTabman()
        binding()
        
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(refreshStatusEvery5Sec), userInfo: nil, repeats: true)
    }
    
    @objc func stopRequestButtonClicked() {
            // delete queue http
    }
    
    @objc func refreshStatusEvery5Sec() {
        
        //viewModel.
    }
    
    func setTabman() {
        
        self.dataSource = self
        addBar(mainView.bar, dataSource: self, at: .top)
    }
    
    func binding() {
        
        
    }
}

extension ResultRequestViewController: PageboyViewControllerDataSource, TMBarDataSource {
    
    // pageboy viewcontroller datasource
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
    
    // tmbardatasource
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        let title = titleList[index]
        return TMBarItem(title: title)
    }
}
