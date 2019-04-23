//
//  ReviewModel.swift
//  User
//
//  Created by Chhem Sronglong on 31/03/2019.
//  Copyright © 2019 100456065. All rights reserved.
//

import Foundation

struct ReviewModel : UserProtocol, ReviewProtocol {
    var memo: String = ""
    
    var timeStamp: Int64 = 0
    
    var text: String = ""
    
    var name: String = ""
    
    var profile: String = ""
    
    var uid: String = ""
    
    var email: String  = ""
    
    var userType: UserType = .user
    
    init(value:  [String : AnyObject]) {
        
        timeStamp = value["timeStamp"] as! Int64
        text = value["text"] as? String ?? ""
        name = value["name"] as? String ?? ""
        profile = value["profile"] as? String ?? ""
        uid = value["uid"] as? String ?? ""
        
    }
    
}

extension ReviewModel {
    static func getReviews(data : Dictionary<String,AnyObject>) -> [ReviewModel]{
        var array = [ReviewModel]()
        for (key, value) in data  {
            print("Key: \(key) - Value: \(value)")
            let review = ReviewModel(value : value as! [String : AnyObject]  )
            print("review")
            array.append(review)
        }
        return array
    }
}
