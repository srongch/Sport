//
//  SplashScreenViewController.swift
//  SportSharing
//
//  Created by Chhem Sronglong on 22/03/2019.
//  Copyright © 2019 100456065. All rights reserved.
//

import UIKit
import Firebase

class SplashScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.router()
        
    }
    
    private func router() {
     AppDelegate.shared.gotoView(view: TabbarEnum.userTabbar())
//        UIApplication.shared.delegate?.window?!.rootViewController = TabbarEnum.userTabbar()
//        UIApplication.shared.delegate?.window??.makeKeyAndVisible()
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

extension SplashScreenViewController{
   static func instance () -> SplashScreenViewController {
        return UIStoryboard.storyboard(.main).instantiateViewController(withIdentifier:SplashScreenViewController.className) as! SplashScreenViewController
    }
}
