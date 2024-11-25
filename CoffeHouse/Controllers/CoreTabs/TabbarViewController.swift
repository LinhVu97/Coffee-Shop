//
//  TabbarViewController.swift
//  CoffeHouse
//
//  Created by Linh Vu on 8/11/24.
//

import UIKit

class CustomTabBar: UITabBar {
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var size = super.sizeThatFits(size)
        size.height = 100 // Điều chỉnh chiều cao tùy theo nhu cầu
        return size
    }
}

class TabbarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setValue(CustomTabBar(), forKey: "tabBar")
        setupView()
    }
    
    private func setupView() {
        tabBar.tintColor = .hex562B1A
        tabBar.backgroundColor = .hexF8F7FA
        
        let homeVC = HomeViewController()
        homeVC.tabBarItem = UITabBarItem(title: MainTab.home.name(),
                                         image: MainTab.home.image(isSelected: true),
                                         tag: 0)
        homeVC.navigationItem.largeTitleDisplayMode = .always
        
        let favouriteVC = FavouriteViewController()
        favouriteVC.tabBarItem = UITabBarItem(title: MainTab.favourite.name(),
                                              image: MainTab.favourite.image(isSelected: true),
                                              tag: 1)
        favouriteVC.navigationItem.largeTitleDisplayMode = .always
        
        let cartVC = CartViewController()
        cartVC.tabBarItem = UITabBarItem(title: MainTab.cart.name(),
                                         image: MainTab.cart.image(isSelected: true),
                                         tag: 2)
        cartVC.navigationItem.largeTitleDisplayMode = .always
        
        let profileVC = ProfileViewController()
        profileVC.tabBarItem = UITabBarItem(title: MainTab.profile.name(),
                                            image: UIImage(named: "ic_profile"),
                                            tag: 3)
        profileVC.navigationItem.largeTitleDisplayMode = .always
        
        let nav1 = UINavigationController(rootViewController: homeVC)
        let nav2 = UINavigationController(rootViewController: favouriteVC)
        let nav3 = UINavigationController(rootViewController: cartVC)
        let nav4 = UINavigationController(rootViewController: profileVC)
        
        setViewControllers([nav1, nav2, nav3, nav4], animated: true)
    }
}
