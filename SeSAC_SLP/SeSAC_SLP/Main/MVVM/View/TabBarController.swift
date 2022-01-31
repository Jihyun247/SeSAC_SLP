//
//  TabBarController.swift
//  SeSAC_SLP
//
//  Created by 김지현 on 2022/01/26.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let firstVC = MapViewController()
        firstVC.tabBarItem = UITabBarItem(title: "홈", image: UIImage(systemName: "home"), selectedImage: UIImage(systemName: "home.act"))
        let firstNVC = UINavigationController(rootViewController: firstVC)
        
        let secondVC = ShopViewController()
        secondVC.tabBarItem = UITabBarItem(title: "새싹샵", image: UIImage(systemName: "shop"), selectedImage: UIImage(systemName: "shop.act"))
        let secondNVC = UINavigationController(rootViewController: secondVC)
        
        let thirdVC = FriendsViewController()
        thirdVC.tabBarItem = UITabBarItem(title: "새싹친구", image: UIImage(systemName: "friends"), selectedImage: UIImage(systemName: "friends.act"))
        let thirdNVC = UINavigationController(rootViewController: thirdVC)
        
        let fourthVC = MyInfoViewController()
        fourthVC.tabBarItem = UITabBarItem(title: "내정보", image: UIImage(systemName: "mypage"), selectedImage: UIImage(systemName: "mypage.act"))
        let fourthNVC = UINavigationController(rootViewController: fourthVC)
        
        setViewControllers([firstNVC, secondNVC, thirdNVC, fourthNVC], animated: true)
        
        let appearance = UITabBarAppearance()
        appearance.configureWithDefaultBackground()
        
        tabBar.standardAppearance = appearance
        tabBar.tintColor = .black
    }
}
