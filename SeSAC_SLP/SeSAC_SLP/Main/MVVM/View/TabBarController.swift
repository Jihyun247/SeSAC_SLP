//
//  TabBarController.swift
//  SeSAC_SLP
//
//  Created by 김지현 on 2022/01/26.
//

import UIKit

class TabBarController: HeightCustomTabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let firstVC = MapViewController()
        firstVC.tabBarItem = UITabBarItem(title: "홈", image: UIImage(named: "home"), selectedImage: UIImage(named: "home.act"))
        let firstNVC = UINavigationController(rootViewController: firstVC)
        
        let secondVC = ShopViewController()
        secondVC.tabBarItem = UITabBarItem(title: "새싹샵", image: UIImage(named: "shop"), selectedImage: UIImage(named: "shop.act"))
        let secondNVC = UINavigationController(rootViewController: secondVC)
        
        let thirdVC = FriendsViewController()
        thirdVC.tabBarItem = UITabBarItem(title: "새싹친구", image: UIImage(named: "friends"), selectedImage: UIImage(named: "friends.act"))
        let thirdNVC = UINavigationController(rootViewController: thirdVC)
        
        let fourthVC = MyInfoViewController()
        fourthVC.tabBarItem = UITabBarItem(title: "내정보", image: UIImage(named: "mypage"), selectedImage: UIImage(named: "mypage.act"))
        let fourthNVC = UINavigationController(rootViewController: fourthVC)
        
        setViewControllers([firstNVC, secondNVC, thirdNVC, fourthNVC], animated: true)
        
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = .white
        
        tabBar.standardAppearance = appearance
        tabBar.tintColor = .sesacGreen
        tabBar.unselectedItemTintColor = .sesacGray6
    }
}
