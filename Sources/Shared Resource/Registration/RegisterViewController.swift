//
//  RegisterViewController.swift
//  SportShare
//
//  Created by Chhem Sronglong on 01/03/2019.
//  Copyright © 2019 Chhem Sronglong. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confrimPasswordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Auth.auth().addStateDidChangeListener() { auth, user in
            if user != nil {
                print("registered")

                UserService.shared.addUser (user: user!) { isError in
                    if (!isError) {
                        UIApplication.shared.keyWindow?.rootViewController = UIStoryboard.storyboard(.views).instantiateViewController(withIdentifier:"AddClassNavigationController")
                    }
                }
            }
        }
        
       
    }
    
    @IBAction func registerPressed(_ sender: Any) {
        
        guard let name = nameTextField.text, name != "",
        let emailAddress = emailTextField.text, emailAddress != "",
        let password = passwordTextField.text, password != "",
        let confirmPwd = confrimPasswordTextField.text, confirmPwd != "" else {
            let alertController = UIAlertController(title: "Registration Error",
                                                    message: "Please make sure you provide your name, email address and password to complete the registration.", preferredStyle: .alert)
            let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(okayAction)
            present(alertController, animated: true, completion: nil)
            return
        }
        
        // Register the user account on Firebase
        Auth.auth().createUser(withEmail: emailAddress, password: password, completion
            : { (user, error) in
                if let error = error {
                    let alertController = UIAlertController(title: "Registration Error", message: error.localizedDescription, preferredStyle: .alert)
                    let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(okayAction)
                    self.present(alertController, animated: true, completion: nil)
                    return
                }
                
                Auth.auth().signIn(withEmail: self.emailTextField.text!,
                                   password: self.passwordTextField.text!)
              
                print(user ?? "default value")
                // Dismiss keyboard
                self.view.endEditing(true)
        }
         )
    
    }
    @IBAction func loginPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
