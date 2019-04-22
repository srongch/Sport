//
//  Like.swift
//  User
//
//  Created by Chhem Sronglong on 21/04/2019.
//  Copyright © 2019 100456065. All rights reserved.
//

import Foundation
import Firebase

struct UserLike {
    var classId : String = ""
    var isLike : Bool = false
    
    init(classId : String, isLike : Bool){
        self.classId = classId
        self.isLike = isLike
    }
    
    init?(snapshot: DataSnapshot) {
         print(snapshot.value)

        guard  let value = snapshot.value as? Bool else {
            print("no value")
            return nil
        }
        
        self.classId = snapshot.key
        self.isLike = value
        
//        self.setupData(value: value,key: snapshot.key)
    }

    mutating func setupData(value : [String:AnyObject] , key : String?){
        //
        guard let classId = key,
            let isLiked = value[classId] as? Bool else {
                return
        }
        self.classId = classId
        self.isLike = isLiked
        

    }
    
}
