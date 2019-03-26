//
//  LevelButtonExtension.swift
//  User
//
//  Created by Chhem Sronglong on 26/03/2019.
//  Copyright © 2019 100456065. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    func setLevelButtonSelected(buttons : [UIButton]){
        if(!self.isSelected){
            self.isSelected = true
            
            buttons.forEach { button in
                if (button == self){
                    self.backgroundColor = UIColor.blueColor
                    self.setTitleColor(UIColor.white, for: .normal)
                }else{
                    button.isSelected = false
                    button.backgroundColor = UIColor.white
                    button.setTitleColor(UIColor.blueColor, for: .normal)
                }
            }
            
        }
    }
}
