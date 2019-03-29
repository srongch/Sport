//
//  ProfileViewCell.swift
//  User
//
//  Created by Chhem Sronglong on 22/03/2019.
//  Copyright © 2019 100456065. All rights reserved.
//

import UIKit

class ProfileViewCell: UITableViewCell {

    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var rightLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(setting : Setting){
        leftLabel.text = setting.text
        if (setting.settingType == .editProfile){
            rightLabel.isHidden = true
        }else{
            rightLabel.isHidden = false
        }
    }

}
