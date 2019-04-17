//
//  BookingCell.swift
//  User
//
//  Created by Chhem Sronglong on 21/03/2019.
//  Copyright © 2019 100456065. All rights reserved.
//

import UIKit
import SDWebImage

class BookingCell: UICollectionViewCell {
    
    @IBOutlet weak var orderId: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    
    @IBOutlet weak var classTitle: UILabel!
    @IBOutlet weak var numberOfPerson: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    func setupCell(model : BookingModel) {
        self.orderId.text = model.orderId
        self.dateLabel.text = model.classDate.toDateWithFormate(format: "MM-dd-YYYY")
        self.levelLabel.text = model.getLevelName().uppercased()
        self.levelLabel.textColor = model.getLevelColor()
        self.classTitle.text = model.className
        self.numberOfPerson.text = "\(model.numberofPeople) person"
        self.totalPrice.text = "Total (GBP): \(Double(model.numberofPeople) * model.price)"
        self.imageView.sd_setImage(with: URL(string: model.classImage), completed: nil)
        
    }
    
    
}
