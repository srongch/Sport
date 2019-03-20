//
//  ClassRegisterModel.swift
//  User
//
//  Created by Chhem Sronglong on 20/03/2019.
//  Copyright © 2019 100456065. All rights reserved.
//

import Foundation

struct ClassRegistration : LevelColorProtocol, ActivityImagesProtocol {
    var levelType: Int
    var activityType: Int
    
    init(level : Int, activity: Int) {
        self.levelType = level
        self.activityType = activity
        
    }
}
