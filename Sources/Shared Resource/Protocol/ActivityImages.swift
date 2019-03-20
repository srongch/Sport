//
//  ActivityImages.swift
//  User
//
//  Created by Chhem Sronglong on 20/03/2019.
//  Copyright © 2019 100456065. All rights reserved.
//

import Foundation

protocol ActivityImagesProtocol {
    var activityType : Int {get set}
    func getActivityIconName() -> String
}

extension ActivityImagesProtocol {
    func getActivityIconName() -> String{
        switch self.activityType {
        case 0: return "workout_icon_white"
        case 1: return "swimming_icon_white"
        case 2: return "football_icon_white"
        case 3: return "snowboard_icon_white"
        default: return "ski_icon_white"
            
        }
    }
}
