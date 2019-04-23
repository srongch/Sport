//
//  ReviewTableViewCell.swift
//  SportShare
//
//  Created by Chhem Sronglong on 04/03/2019.
//  Copyright © 2019 Chhem Sronglong. All rights reserved.
//

import UIKit
import SDWebImage

class ReviewTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var reviewText: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func setupCell(model : ReviewModel){
        
        if (model.name == "Adam3") {
            print(" adam profile : \(model.profile)")
        }
        
        self.profileImage.sd_setImage(with: URL(string: model.profile)) { (_, error, _, _) in
            if let error = error {
                print("error is : \(error.localizedDescription)")
                self.profileImage.image = UIImage(named: "profile_placehold")
            }
        }
        self.userName.text = model.name
        self.date.text = model.timeStamp.toDateWithFormate(format: "MM-dd-YYYY")
        self.reviewText.text = model.text
    }
    
}
