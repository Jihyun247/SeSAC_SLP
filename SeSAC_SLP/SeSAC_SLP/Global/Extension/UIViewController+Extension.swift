//
//  UIViewController+Extension.swift
//  SeSAC_SLP
//
//  Created by 김지현 on 2022/02/11.
//

import UIKit

extension UIViewController {
    
  typealias AlertActionHandler = ((UIAlertAction) -> Void)
  
  func alert(title: String,
             message: String? = nil,
             okTitle: String = "확인",
             cancelTitle: String? = "취소",
             okHandler: AlertActionHandler? = nil,
             cancelHandler: AlertActionHandler? = nil,
             completion: (() -> Void)? = nil) {
      
      let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
      
      if let okClosure = okHandler { // 확인 핸들러 존재할 때
          let okAction: UIAlertAction = UIAlertAction(title: okTitle, style: .destructive, handler: okClosure)
          alert.addAction(okAction)
          let cancelAction: UIAlertAction = UIAlertAction(title: cancelTitle, style: .cancel, handler: cancelHandler)
        alert.addAction(cancelAction)
      } else {
      if let cancelTitle = cancelTitle { // 확인 핸들러 없을 땐 title이 "확인"으로 바뀜
      
          let cancelAction: UIAlertAction = UIAlertAction(title: cancelTitle, style: .cancel, handler: cancelHandler)
              alert.addAction(cancelAction)
        } else {
            let cancelAction: UIAlertAction = UIAlertAction(title: "확인", style: .cancel, handler: cancelHandler)
              alert.addAction(cancelAction)
        }
      }
      self.present(alert, animated: true, completion: completion)
  }
}

