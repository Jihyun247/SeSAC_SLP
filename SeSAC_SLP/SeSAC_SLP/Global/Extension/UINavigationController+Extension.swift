//
//  UINavigationController+Extension.swift
//  SeSAC_SLP
//
//  Created by 김지현 on 2022/02/02.
//

import UIKit

extension UINavigationController {
    
    func initializeNavigationBarWithBackButton(navigationItem: UINavigationItem) {

        navigationBar.barTintColor = .white
        navigationBar.isTranslucent = false
        
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.sesacBlack, NSAttributedString.Key.font: UIFont.title3_M14]
        navigationBar.titleTextAttributes = attributes as [NSAttributedString.Key : Any]
        
        let backButton = UIBarButtonItem(image: UIImage(named: "arrow"), style: .plain, target: self, action: #selector(touchBackButton))
        backButton.tintColor = .black
        
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc func touchBackButton() {
        self.popViewController(animated: true)
    }
    
    func initializeNavigationBarWithoutBackButton(navigationItem: UINavigationItem) {

        navigationBar.barTintColor = .white
        //navigationBar.isTranslucent = false
        
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.sesacBlack, NSAttributedString.Key.font: UIFont.title3_M14]
        navigationBar.titleTextAttributes = attributes as [NSAttributedString.Key : Any]
    }
    
    func navigationBarWithSearchBar(navigationItem: UINavigationItem, searchBar: UISearchBar) {
     
        navigationBar.barTintColor = .white
        navigationBar.isTranslucent = false
        
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.sesacBlack, NSAttributedString.Key.font: UIFont.title3_M14]
        navigationBar.titleTextAttributes = attributes as [NSAttributedString.Key : Any]
        
        let backButton = UIBarButtonItem(image: UIImage(named: "arrow"), style: .plain, target: self, action: #selector(touchBackButton))
        backButton.tintColor = .black
        
        navigationItem.leftBarButtonItem = backButton
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: searchBar)
    }
}
