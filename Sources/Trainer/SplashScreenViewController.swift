//
//  SplashScreenViewController.swift
//  User
//
//  Created by Chhem Sronglong on 18/04/2019.
//  Copyright © 2019 100456065. All rights reserved.
//

import UIKit
import Firebase

class SplashScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        guard let user = Auth.auth().currentUser else{
            print("user not login")
            self.router(isLoggedIn: false)
            return
        }
        print("user is \(user.uid)")
        UserService.shared.getUser(userID: user.uid, email: "", completionHandler: { userModel in
            
            self.router(isLoggedIn: userModel.userType == .trainer)
        })
        
    }
    
    private func router(isLoggedIn : Bool) {
        
        if(isLoggedIn){
            AppDelegate.shared.gotoView(view: SplashScreenViewController.trainerTabbar())
        }else{
            AppDelegate.shared.gotoView(view: TrainerLoginViewController.init())
        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension SplashScreenViewController {
   static func trainerTabbar() -> ESTabBarController {
        let tabBarController = ESTabBarController()
        
        let tabbar = tabBarController.tabBar as! ESTabBar
        
        tabbar.barTintColor = UIColor.background_color
        tabbar.layer.borderWidth = 0
        tabbar.clipsToBounds = true
        tabbar.backgroundColor = UIColor.background_color
        tabbar.isTranslucent = false
        tabbar.itemCustomPositioning = .centered
        
        let v1 = HomeViewController.instance()
        let v2 = ClassListViewController.instance()
        let v3 = TrainerTimeTableViewController()
        let v4 = TrainerProfileViewController.instance()
        
        v1.tabBarItem = ESTabBarItem.init(ExampleBackgroundContentView(),title: nil, image: UIImage(named: "state_off"), selectedImage: UIImage(named: "state_on"))
        v2.tabBarItem = ESTabBarItem.init(ExampleBackgroundContentView(),title: nil, image: UIImage(named: "class_off"), selectedImage: UIImage(named: "class_on"))
        v3.tabBarItem = ESTabBarItem.init(ExampleBackgroundContentView(),title: nil, image: UIImage(named: "alarm_tab"), selectedImage: UIImage(named: "alarm_tab_on"))
     v4.tabBarItem = ESTabBarItem.init(ExampleBackgroundContentView(),title: nil, image: UIImage(named: "bar_icon_profile"), selectedImage: UIImage(named: "bar_icon_profile_select"))
        
        tabBarController.viewControllers = [v1, v2,v3,v4]
        
        return tabBarController
    }
}

