//
//  LoginViewController.swift
//  SportShare
//
//  Created by Chhem Sronglong on 01/03/2019.
//  Copyright © 2019 Chhem Sronglong. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passWordTextField: UITextField!
    @IBOutlet weak var closeButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if (self.isModal()){
            closeButton.isHidden = false
        }else{
            closeButton.isHidden = true
        }

    }
    
    func printHeadline() {
        print("HEADLINE: Objective-C dies peacefully in sleep")
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        self.dismiss(animated: true) {
            print("dismiss complete")
        }
    }
    
    func loginSucces (){
        
        if(self.isModal()){
            self.dismiss(animated: true) {
                print("view dismissed")
            }
        }else{
                                print("registered")
                                UIApplication.shared.keyWindow?.rootViewController = UIStoryboard.storyboard(.views).instantiateViewController(withIdentifier:"AddClassNavigationController")
        }

    }
    
    
    @IBAction func loginpressed(_ sender: Any) {
        // Validate the input
        guard let emailAddress = emailTextField.text, emailAddress != "",
            let password = passWordTextField.text, password != "" else {
                
                let alertController = UIAlertController(title: "Login Error", message: "Both fields must not be blank.", preferredStyle: .alert)
                let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(okayAction)
                present(alertController, animated: true, completion: nil)
                
                return
        }
        
        AuthService().signInWith(email: emailAddress, password: password) { error  in
            if (error!) {
                print("login faild")
            }else{
                self.loginSucces()
            }
        }
        
        
        
        
//        UserService.shared.signInWith(email: emailAddress, password: password) { (result, error) in
//            print("dfgfd")
////                        if let error = error {
////                            let alertController = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle: .alert)
////                            let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
////                            alertController.addAction(okayAction)
////                            self.present(alertController, animated: true, completion: nil)
////
////                            return
////                        }
//        }
        

        
//        // Perform login by calling Firebase APIs
//        Auth.auth().signIn(withEmail: emailAddress, password: password, completion: { (result, error) in
//
//            if let error = error {
//                let alertController = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle: .alert)
//                let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
//                alertController.addAction(okayAction)
//                self.present(alertController, animated: true, completion: nil)
//
//                return
//            }
//
//
//            // Dismiss keyboard
//            self.view.endEditing(true)
//
//            print("resut \(result?.user.email)")
//
//            // Present the main view
////            if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "MainView") {
////                UIApplication.shared.keyWindow?.rootViewController = viewController
////                self.dismiss(animated: true, completion: nil)
////            }
//
//        })
//
    }
    
    
    @IBAction func registerPressed(_ sender: Any) {
//
//        self.navigationController?.pushViewController(UIStoryboard.storyboard(.registration).instantiateViewController(withIdentifier:RegisterViewController.storyboardIdentifier), animated:true)
////        UIApplication.shared.keyWindow?.rootViewController = UIStoryboard.storyboard(.views).instantiateViewController(withIdentifier:"AddClassNavigationController")
        
        
        
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//         Get the new view controller using segue.destination.
//         Pass the selected object to the new view controller.
        if segue.identifier == "registrationSegue"
        {
            if let destinationVC = segue.destination as? RegisterViewController {
                destinationVC.delegate =  isModal() ? self : nil
            }
        }
//
    }
 

}

extension LoginViewController : RegistrationDelegate{
    func registrationDidFinish() {
        print("registration finish")
        self.dismiss(animated: true, completion: nil)
    }
}

extension LoginViewController {
    static func instance ()-> UINavigationController {
        return UIStoryboard.storyboard(.registration).instantiateViewController(withIdentifier:"RegistrationNavigation") as! UINavigationController
    }

}
