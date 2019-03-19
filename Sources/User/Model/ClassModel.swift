//
//  ClassModel.swift
//  User
//
//  Created by 100456065 on 19/03/2019.
//  Copyright © 2019 100456065. All rights reserved.
//

import Foundation
import Firebase

enum ActivityTypeEnum : String{
    case beginner
    case intermediate
    case advance

}


struct ClassModel : ModeltoDictionaryProtocol {
    var activityType: Int = 0
    var levelType: Int = 0
    
    var classPrice: Double = 0
    
    var className: String = ""
    var classAbout: String = ""
    var timeTable: String = ""
    var equipment: String = ""
    
    var times : [Int64] = []
    var dayoftheWeek:  [Int] = []
    var hours:  [Int] = []
    var imageArray:  [String] = []
    
    var location: String = ""
    var latitude: Double = 0
    var longtitude: Double = 0
    
    var startDate: Int64 = 0
    var endDate: Int64 = 0
    var timeStamp: Int64 = 0
    
    init(){}
    
    var levelName: String {
        get {
            switch self.activityType {
            case 0: return ActivityTypeEnum.beginner.rawValue.uppercased()
            case 1: return ActivityTypeEnum.intermediate.rawValue.uppercased()
            case 2: return ActivityTypeEnum.advance.rawValue.uppercased()
            default:
                return ActivityTypeEnum.beginner.rawValue.uppercased()
            }
        }
    }

    init?(snapshot: DataSnapshot) {
        print(snapshot)
//
        guard
            let value = snapshot.value as? [String: AnyObject],
            let activityType = value["activityType"] as? Int,
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
                return nil
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
        
    }
    
}
