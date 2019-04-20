//
//  UserProtocol.swift
//  User
//
//  Created by Chhem Sronglong on 28/03/2019.
//  Copyright © 2019 100456065. All rights reserved.
//

import Foundation
import Firebase

enum UserType : String {
    case user = "user"
    case trainer = "trainer"
    
}

extension UserType {
    static func getType()->UserType {
        let bundle = Bundle.main.bundleIdentifier
        return bundle! == "trainer.sronglong.me" ? UserType.trainer : UserType.user
    }
}

protocol UserProtocol {
    var name : String {get set}
    var profile : String {get set}
    var uid : String {get set}
    var email : String {get set}
    var userType : UserType {get set}
    var memo : String {get set}
}

struct CustomUser: UserProtocol {
    var userType: UserType
    
    var email: String
    
    var name: String
    
    var profile: String
    
    var uid: String
    
    var memo: String
    

    init(name : String, profile : String, uid : String, email : String, userType : UserType, memo: String = "") {
        self.name = name
        self.profile = profile
        self.uid = uid
        self.email = email
        self.userType = userType
        self.memo = memo
    }
    
    init?(snapshot: DataSnapshot) {

        guard
            let value = snapshot.value as? [String:AnyObject],
            let name = value["name"] as? String,
            let profile = value["profile"] as? String,
            let uid = value["uid"] as? String,
            let email = value["email"] as? String,
            let userType = value["userType"] as? String else {
                return nil
        }
        
        self.name = name
        self.profile = profile
        self.uid = uid
        self.email = email
        self.userType = UserType(rawValue: userType)!
        self.memo = value["memo"] as? String ?? ""
    }
    
    
}





