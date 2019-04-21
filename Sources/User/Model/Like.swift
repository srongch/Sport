//
//  Like.swift
//  User
//
//  Created by Chhem Sronglong on 21/04/2019.
//  Copyright © 2019 100456065. All rights reserved.
//

import Foundation

struct UserLike {
    var classId : String
    var isLike : Bool
    
    init?(snapshot: DataSnapshot) {
        // print(value)

        guard  let value = snapshot.value as? [String:AnyObject] else {
            print("no value")
            return nil
        }
        setupData(value: value,key: snapshot.key)
    }

//    init?(value : [String:AnyObject] ) {
//        setupData(value: value, key: nil)
//    }
//
    mutating func setupData(value : [String:AnyObject] , key : String?){
        //
        guard
            let activityType = value["classId"] as? Int,
            let levelType = value["levelType"] as? Int,
            let classPrice = value["classPrice"] as? Double,

            let className = value["className"] as? String,
            let classAbout = value["classAbout"] as? String,
            let timeTable = value["timeTable"] as? String,
            let equipment = value["equipment"] as? String,

            let times = value["times"] as? [Int64],
            let dayoftheWeek = value["dayoftheWeek"] as? [Int],
            let hours = value["hours"] as? [Int],
            let imageArray = value["imageArray"] as? [String],

            let location = value["location"] as? String,
            let latitude = value["latitude"] as? Double,
            let longtitude = value["longtitude"] as? Double,

            let startDate = value["startDate"] as? Int64,
            let endDate = value["endDate"] as? Int64,
            let timeStamp = value["timeStamp"] as? Int64 else {
                return
        }

        self.activityType = activityType
        self.levelType = levelType
        self.classPrice = classPrice

        self.className = className
        self.classAbout = classAbout
        self.timeTable = timeTable
        self.equipment = equipment

        self.times = times
        self.dayoftheWeek = dayoftheWeek
        self.hours = hours
        self.imageArray = imageArray

        self.location = location
        self.latitude = latitude
        self.longtitude = longtitude

        self.startDate = startDate
        self.endDate = endDate
        self.timeStamp = timeStamp
        self.rating = ratingValue
        self.key = key ?? ""
        self.reviews = value["reviews"] as? Int ?? 0
        self.authorId = value["authorId"] as? String ?? ""
        self.authorName = value["authorName"] as? String ?? ""
        self.authorDesc = value["description"] as? String ?? ""
    }
    
}
