//
//  TrainerLoginViewController.swift
//  Trainer
//
//  Created by Chhem Sronglong on 23/04/2019.
//  Copyright © 2019 100456065. All rights reserved.
//

import UIKit

class TrainerLoginViewController: UIViewController {

    let vc =  LoginViewController.instance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       self.setupView()
        // Do any additional setup after loading the view.
    }
    
    func setupView(){
        add(vc)
        let loginView = vc.visibleViewController as! LoginViewController
        loginView.isModal = false
        loginView.delegate = self
        
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

extension TrainerLoginViewController : LoginViewControllerProtocol{
    func loginDidSucess() {
        AppDelegate.shared.gotoView(view: SplashScreenViewController.trainerTabbar())
    }
    
    //    func login
}
