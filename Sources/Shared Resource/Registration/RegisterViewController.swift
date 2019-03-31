//
//  RegisterViewController.swift
//  SportShare
//
//  Created by Chhem Sronglong on 01/03/2019.
//  Copyright © 2019 Chhem Sronglong. All rights reserved.
//

import UIKit
import Firebase

protocol  RegistrationDelegate{
    func registrationDidFinish()
}

class RegisterViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confrimPasswordTextField: UITextField!
    
     var delegate : RegistrationDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        AuthService().signUpWith(email: emailAddress, password: password, name: password, userType :.user ) { (user, error,errorMsg) in
            if (error){
                let alertController = UIAlertController(title: "Registration Error", message: errorMsg, preferredStyle: .alert)
                let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(okayAction)
                self.present(alertController, animated: true, completion: nil)
                return
            }
            
            // Dismiss keyboard
            self.view.endEditing(true)
            
//            print("registreation with name\(user?.name) and password : \(user?.uid)" )
            
            if(self.isModal()){
                if let delegate = self.delegate {
                    delegate.registrationDidFinish()
                }
                return
            }
            
            
        }
    
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
