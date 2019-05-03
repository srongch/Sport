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

//    var imageArray : Array<Any> {
//
//    }
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let imageArray = [UIImage(named: "animation1"),
                          UIImage(named: "animation2"),
                          UIImage(named: "animation3"),
                          UIImage(named: "animation4"),
                          UIImage(named: "animation5")]
        
        imageView.animationImages = imageArray as! [UIImage]
        imageView.animationDuration = 0.9
        imageView.startAnimating()
        // Do any additional setup after loading the view.
        let user = Auth.auth().currentUser;
        
        if ((user) != nil) {
            // User is signed in.
             UserService.shared.getUser(userID: user!.uid, email: "", completionHandler: { _ in
//                self.imageView.stopAnimating()
                  self.router()
             })
        }else{
           
            self.router()
        }
   
        
    }
    
    private func router() {
         self.imageView.stopAnimating()
     AppDelegate.shared.gotoView(view: TabbarEnum.userTabbar())
  
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
