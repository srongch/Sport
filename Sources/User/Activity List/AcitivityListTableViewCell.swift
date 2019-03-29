//
//  AcitivityListTableViewCell.swift
//  SportShare
//
//  Created by Chhem Sronglong on 02/03/2019.
//  Copyright © 2019 Chhem Sronglong. All rights reserved.
//

import UIKit
import SDWebImage

class AcitivityListTableViewCell: UITableViewCell {

    @IBOutlet weak var classImage: UIImageView!
    @IBOutlet weak var level: UILabel!
    @IBOutlet weak var classTitle: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
   func setupCell(model : ClassModel) {
    level.text = model.getLevelName().uppercased()
    level.textColor = model.getLevelColor()
    classTitle.text = model.className
    price.text = "$\(model.classPrice)"
    rating.text = "\(model.rating)"
    let urlString = model.imageArray[0]
    classImage.sd_setImage(with: URL(string: urlString), completed: nil)
    }

}
