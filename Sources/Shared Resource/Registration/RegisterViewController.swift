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
        
        if password != confirmPwd {
            presentAlertView(with: "Password not matches.", isOneButton: true, onDone: {}, onCancel: {})
            return
        }
        
        
        let vc = LoadingViewController.instance(self.view.frame)
        add(vc)
        // Register the user account on Firebase
        AuthService().signUpWith(email: emailAddress, password: password, name: name, userType :UserType.getType()) {[weak self] (user, error,errorMsg) in
            vc.remove()
            if (error){
                let alertController = UIAlertController(title: "Registration Error", message: errorMsg, preferredStyle: .alert)
                let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(okayAction)
                self?.present(alertController, animated: true, completion: nil)
                return
            }
            
            // Dismiss keyboard
            self?.view.endEditing(true)
            
//            print("registreation with name\(user?.name) and password : \(user?.uid)" )
            self?.delegate?.registrationDidFinish()
//            if(self.isModal()){
//                if let delegate = self.delegate {
//                    delegate.registrationDidFinish()
//                }
//                return
//            }else{
//                UIApplication.shared.keyWindow?.rootViewController = UIStoryboard.storyboard(.views).instantiateViewController(withIdentifier:"AddClassNavigationController")
//            }
            
            
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
