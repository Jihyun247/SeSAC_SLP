//
//  MyInfoViewModel.swift
//  SeSAC_SLP
//
//  Created by 김지현 on 2022/01/28.
//

import UIKit
import RxSwift
import RxCocoa

// Input Output 구조 적용

class MyInfoViewModel {
    
    private var disposeBag = DisposeBag()
    
    var myInfoCellList = BehaviorRelay<[MyInfo]>(value: [])
    
    
    func getSelectedMyInfo(row: Int, completion: @escaping (Int) -> Void ) {
        completion(myInfoCellList.value[row].id)
    }
    
    func setList() {

        let notice = MyInfo(id: 0, iconImage: UIImage(named: "notice")!, labelText: "공지사항")
        let faq = MyInfo(id: 0, iconImage: UIImage(named: "faq")!, labelText: "자주 묻는 질문")
        let qna = MyInfo(id: 0, iconImage: UIImage(named: "qna")!, labelText: "1:1 문의")
        let setAlarm = MyInfo(id: 0, iconImage: UIImage(named: "setting_alarm")!, labelText: "알림 설정")
        let permit = MyInfo(id: 0, iconImage: UIImage(named: "permit")!, labelText: "이용 약관")
        
        myInfoCellList.accept([notice, faq, qna, setAlarm, permit])
    }
}

