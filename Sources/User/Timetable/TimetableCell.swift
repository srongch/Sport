//
//  TimetableCell.swift
//  User
//
//  Created by Chhem Sronglong on 20/03/2019.
//  Copyright © 2019 100456065. All rights reserved.
//

import UIKit

class TimetableCell: UICollectionViewCell {
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var dayNumberLabel: UILabel!
    @IBOutlet weak var dayofWeekLabel: UILabel!
    
    public func setupView(isSelected : Bool){
        self.view.backgroundColor = isSelected ? UIColor.blueColor : UIColor.white
        self.dayNumberLabel.textColor = isSelected ? UIColor.white : UIColor.blueColor
        self.dayofWeekLabel.textColor = isSelected ? UIColor.white : UIColor.blueColor
    }
    
}
