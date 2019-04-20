//
//  UserEditProfileViewController.swift
//  User
//
//  Created by Chhem Sronglong on 20/04/2019.
//  Copyright © 2019 100456065. All rights reserved.
//

import UIKit

class UserEditProfileViewController: UIViewController {


    let vc =  EditProfileViewController.instance()
    var delegate : EditProfileProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.setupView()
        self.loadData()
    }
    
    func setupView(){
        add(vc)
        self.vc.delegate = self
        self.vc.setHideMemo()
    }
    
    func loadData(){
        UserService.shared.getUser(userID: UserService.shared.globalUser!.uid , email: "") { userModel in
            self.vc.setupData(userModel: userModel)
        }
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

extension UserEditProfileViewController : EditProfileProtocol{
    func editProfileBackPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func editProfileSaveComplete() {
        self.navigationController?.popViewController(animated: true)
        self.delegate?.editProfileSaveComplete()
    }
    
    
}
