//
//  TabbarEnum.swift
//  SportSharing
//
//  Created by Chhem Sronglong on 22/03/2019.
//  Copyright © 2019 100456065. All rights reserved.
//

import Foundation
import UIKit

enum TabbarEnum {
    static func userTabbar() -> ESTabBarController {
        let tabBarController = ESTabBarController()
        
        let tabbar = tabBarController.tabBar as! ESTabBar
        
        tabbar.barTintColor = UIColor.background_color
        tabbar.layer.borderWidth = 0
        tabbar.clipsToBounds = true
        tabbar.backgroundColor = UIColor.background_color
        tabbar.isTranslucent = false
        tabbar.itemCustomPositioning = .centered
        
        let v1 = HomeViewController.instance()
        let v2 = TimetableViewController.instance()
        let v3 = ProfileViewController.instance()
        
        v1.tabBarItem = ESTabBarItem.init(ExampleBackgroundContentView(),title: nil, image: UIImage(named: "bar_icon_home"), selectedImage: UIImage(named: "bar_icon_home_select"))
        v2.tabBarItem = ESTabBarItem.init(ExampleBackgroundContentView(),title: nil, image: UIImage(named: "bar_icon_schedule"), selectedImage: UIImage(named: "bar_icon_schedule_select"))
        v3.tabBarItem = ESTabBarItem.init(ExampleBackgroundContentView(),title: nil, image: UIImage(named: "bar_icon_profile"), selectedImage: UIImage(named: "bar_icon_profile_select"))
        
        tabBarController.viewControllers = [v1, v2,v3]
        
        return tabBarController
    }
}
