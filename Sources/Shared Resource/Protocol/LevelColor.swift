//
//  LevelColor.swift
//  User
//
//  Created by Chhem Sronglong on 20/03/2019.
//  Copyright © 2019 100456065. All rights reserved.
//

import UIKit

protocol LevelColorProtocol{
   var levelType : Int {get set}
   func getLevelColor() -> UIColor
   func getLevelName() -> String
}

extension LevelColorProtocol {

    func getLevelColor() -> UIColor{
        switch self.levelType {
        case 0: // Beginner
            return UIColor.level_0
        case 1: // Intermediate
            return UIColor.level_1
        default: // case 2 " Advnace
            return UIColor.level_2
        }
    }
    
    func getLevelName() -> String {
        switch self.levelType {
        case 0: // Beginner
            return "Biginner"
        case 1: // Intermediate
            return "Intermediate"
        default: // case 2 " Advnace
            return "Advance"
        }
    }
}

