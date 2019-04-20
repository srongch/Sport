//
//  ProfileHeaderView.swift
//  User
//
//  Created by Chhem Sronglong on 22/03/2019.
//  Copyright © 2019 100456065. All rights reserved.
//

import UIKit

class ProfileHeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var emailLable: UILabel!
    @IBOutlet weak var memoLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var quote_icon: UIImageView!
    //   @IBOutlet weak var memoLabel: UILabel!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    func setupNoLogin (){
        imageView.image = UIImage(named: "profile_placehold")
        nameLable.text = "Jonh Doe"
        emailLable.text = "email@example.com"
        memoLabel.text = ""
        quote_icon.isHidden = true
    }
    
    func setupUser (user : UserProtocol){
        self.imageView.sd_setImage(with: URL(string: user.profile), completed: { [weak self] (image, error, cacheType, imageURL) in
            guard let image = image else{
                self?.imageView.image = UIImage(named: "profile_placehold")
                return
            }
            self?.imageView.image = image
        })
        nameLable.text = user.name
        emailLable.text = user.email
        memoLabel.text = user.memo
        quote_icon.isHidden = true
    }
    
    func setupForTrainer(){
        quote_icon.isHidden = false
    }
    

}

class ProfileFooterView : UITableViewHeaderFooterView {
    @IBOutlet weak var button: UIButton!
    func setupNoLogin (isLogin : Bool){
        button.setTitle(isLogin ? "Logout" : "Login", for: .normal)
    }
}
