//
//  EditProfileViewController.swift
//  Trainer
//
//  Created by Chhem Sronglong on 20/04/2019.
//  Copyright © 2019 100456065. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {

    @IBOutlet weak var naviView: AddClassNavi!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self .setupView()
    }
    
    func setupView(){
        naviView.delegate = self
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

extension EditProfileViewController : AddClassNaviProtocol{
    func closeButtonDidPressed() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension EditProfileViewController  {
    static func instance ()-> EditProfileViewController {
        return UIStoryboard.storyboard(.profile).instantiateViewController(withIdentifier:"EditProfileViewController") as! EditProfileViewController
    }
}
