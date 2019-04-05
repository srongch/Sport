//
//  UIViewController+StoryboardIdentifier.swift
//  AHStoryboard
//
//  Created by Andyy Hope on 19/01/2016.
//  Copyright © 2016 Andyy Hope. All rights reserved.
//

import UIKit

extension UIViewController : StoryboardIdentifiable { }

extension UIViewController {
    func isModal() -> Bool {
        return self.presentingViewController?.presentedViewController == self
            || (self.navigationController != nil && self.navigationController?.presentingViewController?.presentedViewController == self.navigationController)
            || self.tabBarController?.presentingViewController is UITabBarController
    }
    
    //MAR: add & remove ChildView
    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func remove() {
        // Just to be safe, we check that this view controller
        // is actually added to a parent before removing it.
        guard parent != nil else {
            return
        }
        
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
    
//    https://gist.github.com/evgeniyd/c534c028d6b4478800dcacd06a382051
    //MARK : Present Alert view
    func presentAlertView(with message : String, isOneButton : Bool, onDone: @escaping  ()->Void, onCancel: @escaping ()->Void){
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
           onDone()
            }))
    
        if (!isOneButton) {
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
            onCancel()
            }))
        }

        self.present(alert, animated: true, completion: nil)
    }
    
}


