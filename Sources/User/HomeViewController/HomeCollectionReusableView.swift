//
//  HomeCollectionReusableView.swift
//  SportShare
//
//  Created by Chhem Sronglong on 01/03/2019.
//  Copyright © 2019 Chhem Sronglong. All rights reserved.
//

import UIKit
import SDWebImage

class HomeCollectionReusableView: UICollectionReusableView {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var welcomeLabel: UILabel!
    
    
    @IBOutlet weak var workoutButton: CategoryButton!
    @IBOutlet weak var swimming: CategoryButton!
    @IBOutlet weak var footButton: CategoryButton!
    @IBOutlet weak var snowboardingButton: CategoryButton!
    @IBOutlet weak var skiingButton: CategoryButton!
    
    override func awakeFromNib() {
        print("collect header awake")
        workoutButton.setButton(buttonType: .workout, selectionStyle: .flashSelection, delegate: nil)
        swimming.setButton(buttonType: .swimming, selectionStyle: .flashSelection, delegate: nil)
        footButton.setButton(buttonType: .football, selectionStyle: .flashSelection, delegate: nil)
        snowboardingButton.setButton(buttonType: .snowboarding, selectionStyle: .flashSelection, delegate: nil)
        skiingButton.setButton(buttonType: .skiing, selectionStyle: .flashSelection, delegate: nil)
    }
    
    func setDelegate(deletgate : CategoryButtonPressedProtocol){
        workoutButton.buttonDelegate = deletgate
         swimming.buttonDelegate = deletgate
         footButton.buttonDelegate = deletgate
         snowboardingButton.buttonDelegate = deletgate
        skiingButton.buttonDelegate = deletgate
    }
    
    func setupHeaderForNotLogin(){
        nameLabel.text = "Hi!"
        welcomeLabel.text = "Welcome, what you wanna do today?"
        self.profileImage.image = UIImage(named: "main_profile")
        self.profileImage.contentMode = .center
    }
    
    func setupHeaderForLogin(user: UserProtocol){
        self.profileImage.sd_setImage(with: URL(string: user.profile), completed: { [weak self] (image, error, cacheType, imageURL) in
            guard let image = image else{
                self?.profileImage.image = UIImage(named: "main_profile")
                self?.profileImage.contentMode = .center
                return
            }
            self?.profileImage.image = image
            self?.profileImage.contentMode = .scaleAspectFill
        })
        nameLabel.text = "Hi! \(user.name)"
        welcomeLabel.text = "Welcome back \(user.name), what you wanna do today?"
        
    }
    
    
}
