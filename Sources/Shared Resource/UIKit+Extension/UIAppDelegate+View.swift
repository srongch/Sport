//
//  UIAppDelegate+View.swift
//  SportSharing
//
//  Created by Chhem Sronglong on 18/04/2019.
//  Copyright © 2019 100456065. All rights reserved.
//

import UIKit


extension AppDelegate {
    
    static var shared: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    func gotoView(view : UIViewController) {
        window?.rootViewController = view
        window?.makeKeyAndVisible()
    }
}
