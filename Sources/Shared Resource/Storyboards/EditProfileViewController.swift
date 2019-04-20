//
//  EditProfileViewController.swift
//  Trainer
//
//  Created by Chhem Sronglong on 20/04/2019.
//  Copyright © 2019 100456065. All rights reserved.
//

import UIKit
import SDWebImage

protocol EditProfileProtocol {
    func editProfileBackPressed()
    func editProfileSaveComplete()
}

class EditProfileViewController: UIViewController {

    @IBOutlet weak var naviView: AddClassNavi!
    @IBOutlet weak var memoStackView: UIStackView!
    
    var delegate : EditProfileProtocol?
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var memoTextField: UITextView!
    
    var userModel : UserProtocol?
    var imageChange : UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self .setupView()
    }
    
    func setupView(){
        naviView.delegate = self
    }
    
    func setupData(userModel : UserProtocol){
        self.userModel = userModel
        self.profileImage.sd_setImage(with: URL(string: userModel.profile), completed: { [weak self] (image, error, cacheType, imageURL) in
            guard let image = image else{
                self?.profileImage.image = UIImage(named: "profile_placehold")
                return
            }
            self?.profileImage.image = image
        })
        emailTextField.text  = userModel.email
        nameTextField.text = userModel.name
        memoTextField.text = userModel.memo
    }
    
//    tempModel.imageArray.map({$0.jpegData(compressionQuality: 0.9)!})
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        
        guard var model = self.userModel else{
            return
        }
        
        if !memoStackView.isHidden {
            guard let memo = self.memoTextField.text, self.memoTextField.text.count > 0 else {
                presentAlertView(with: "Please enter memo text.", isOneButton: true, onDone: {}, onCancel: {})
                return
            }
            model.memo = memo
        }
        
        let vc = LoadingViewController.instance(self.view.frame)
        add(vc)
        
        UserService.shared.editUser(user: model, image:imageChange?.jpegData(compressionQuality: 0.9) ?? nil, completionHandler: { isError in
            vc.remove()
            guard !isError else{
                self.presentAlertView(with: "Option Failed. Retry?", isOneButton: false, onDone: {
                    self.saveButtonPressed(self)
                }, onCancel: {})
                return
            }
            
            self.presentAlertView(with: "Profile Saved", isOneButton: true, onDone: {
//                self.navigationController?.popViewController(animated: true)
                self.delegate?.editProfileSaveComplete()
            }, onCancel: {})
            
            
        })
    }
    
    @IBAction func editButtonPressed(_ sender: Any) {
        self.addImagePressed()
    }
    
    func addImagePressed (){
        print("add image")
        CameraHandler.shared.showActionSheet(vc: self)
        CameraHandler.shared.imagePickedBlock = { (image) in
            /* get your image here */
            self.profileImage.image = image
            self.imageChange = image
//            self.updateCollectionView()
        }
    }
    
    func setHideMemo(){
        memoStackView.isHidden = true
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
       self.delegate?.editProfileBackPressed()
    }
}

extension EditProfileViewController  {
    static func instance ()-> EditProfileViewController {
        return UIStoryboard.storyboard(.profiles).instantiateViewController(withIdentifier:"EditProfileViewController") as! EditProfileViewController
    }
}
