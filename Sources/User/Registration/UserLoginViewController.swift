//
//  UserLoginViewController.swift
//  User
//
//  Created by Chhem Sronglong on 20/04/2019.
//  Copyright © 2019 100456065. All rights reserved.
//

import UIKit

class UserLoginViewController: UIViewController {

     let vc =  LoginViewController.instance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        // Do any additional setup after loading the view.
    }
    
    func setupView(){
        add(vc)
        let loginView = vc.visibleViewController as! LoginViewController
        loginView.isModal = true
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

extension UserLoginViewController : LoginViewControllerProtocol{
    func loginDidSucess() {
        self.dismiss(animated: true, completion: nil)
//        self.dismiss(animated: true, completion: nil)
    }
    
//    func login
}
