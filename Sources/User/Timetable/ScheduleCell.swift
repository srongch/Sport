//
//  ScheduleCell.swift
//  User
//
//  Created by Chhem Sronglong on 20/03/2019.
//  Copyright © 2019 100456065. All rights reserved.
//

import UIKit

class ScheduleCell: UICollectionViewCell {
    
    @IBOutlet weak var levelButton: UIButton!
    
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var lineView: UIView!
    
    @IBOutlet weak var activityImage: UIImageView!

    @IBOutlet weak var classTitle: UILabel!
    @IBOutlet weak var classAddress: UILabel!
    
    func setupCell(model : TimeTable){
        self.levelButton.setTitle(model.getLevelName().uppercased(), for: .normal)
        self.levelButton.backgroundColor = model.getLevelColor()
        self.lineView.backgroundColor = model.getLevelColor()
        self.activityImage.image = UIImage(named: model.getActivityIconName())
        
        hourLabel.text = model.time.toDateWithFormate(format: "HH:ss")
        classTitle.text = model.title
        classAddress.text = model.location
        
    }
    
    
}
