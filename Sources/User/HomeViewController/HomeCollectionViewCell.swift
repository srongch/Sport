//
//  HomeCollectionViewCell.swift
//  SportShare
//
//  Created by Chhem Sronglong on 01/03/2019.
//  Copyright © 2019 Chhem Sronglong. All rights reserved.
//

import UIKit
import SDWebImage


class HomeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var ratingLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var classNameLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    internal func setupCell(model: ClassModel){
        ratingLabel.text = "\(model.rating)"
        if(model.imageArray.count > 0){ imageView.sd_setImage(with: URL(string: model.imageArray.first!), completed: nil)}
        
        levelLabel.text = model.getLevelName()
        levelLabel.textColor = model.getLevelColor()
        classNameLabel.text = model.className
        priceLabel.text = "£\(model.classPrice)"
        
    }
    
    
}
