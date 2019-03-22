//
//  HomeCollectionReusableView.swift
//  SportShare
//
//  Created by Chhem Sronglong on 01/03/2019.
//  Copyright © 2019 Chhem Sronglong. All rights reserved.
//

import UIKit

class HomeCollectionReusableView: UICollectionReusableView {
    
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
    
    
}
