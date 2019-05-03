//
//  HomeTabCell.swift
//  Trainer
//
//  Created by Chhem Sronglong on 10/04/2019.
//  Copyright © 2019 100456065. All rights reserved.
//

import UIKit
import SDWebImage

class HomeTabCell: UITableViewCell {

    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var classTitle: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var profileView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(bookingModel : BookingModel){
        profileView.sd_setImage(with: URL(string: bookingModel.profile), completed: nil)
        name.text = bookingModel.name
        classTitle.text = bookingModel.className
        amount.text = "£\(bookingModel.price * Double(bookingModel.numberofPeople))"
    }
    
}
