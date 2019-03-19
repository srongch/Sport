//
//  NaviBar.swift
//  User
//
//  Created by 100456065 on 19/03/2019.
//  Copyright © 2019 100456065. All rights reserved.
//

import UIKit

class NaviBar: NibView {

    @IBOutlet weak var naviTitle: UILabel!
    @IBOutlet weak var backButton: UIButton!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    @IBInspectable var title: String = "" {
        didSet {
            self.naviTitle.text = title
        }
    }

}
