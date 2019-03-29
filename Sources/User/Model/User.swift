//
//  User.swift
//  User
//
//  Created by Chhem Sronglong on 28/03/2019.
//  Copyright © 2019 100456065. All rights reserved.
//

import Foundation
import Firebase

extension User : UserProtocol {
    var profile: String {
        get {
            return self.profile
        }
        set(newValue) {
            self.profile = newValue
        }
    }
    
    var name : String {
        get {
            return self.name
        }
        set(newValue) {
            self.name =  newValue
        }
    }

    
}
