//
//  ClassModel.swift
//  Trainer
//
//  Created by Chhem Sronglong on 16/03/2019.
//  Copyright © 2019 100456065. All rights reserved.
//

import Foundation
import UIKit

enum DayoftheWeek {
    case monday
    case tuseday
    case wednesday
    case thursday
    case friday
    case saturday
    case sunday
}


struct ClassModel {
    
    var activityType : Int
    var levelType : Int
    var location : String
    var latitude : Double
    var longtitude : Double
    var className : String
    var classPrice : Double
    var imageArray: [UIImage] = []
    
    var classAbout : String
    var timeTable : String
    var equipment : String
    
    var startDate : Date?
    var startDateString : String {
        get {
            guard let date = startDate else {
                return "Select start date"
            }
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            return dateFormatter.string(from:date)
        }
    }
    var endDate : Date?
    var endDateString : String {
        get {
            guard let date = endDate else {
                return "Select end date"
            }
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            return dateFormatter.string(from:date)
        }
    }
    
    var dayoftheWeek =  Set<Int>()
    var hours : [Int] = []
    var times : [Date] = []
    
    
    
    init(activityType : Int,
         levelType : Int,
         location : String,
         latitude : Double,
         longtitude : Double,
         className : String,
         classPrice : Double,
         imageArray: [UIImage]? = []) {
        self.activityType = activityType
        self.levelType = levelType
        self.location = location
        self.latitude = latitude
        self.longtitude = longtitude
        self.className = className
        self.classPrice = classPrice
        self.imageArray = imageArray!
        self.classAbout = ""
        self.timeTable = ""
        self.equipment = ""
    }
    
}
