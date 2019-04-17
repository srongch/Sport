//
//  BookingModel.swift
//  User
//
//  Created by Chhem Sronglong on 04/04/2019.
//  Copyright © 2019 100456065. All rights reserved.
//

import Foundation

struct BookingModel : ModeltoDictionaryProtocol,LevelColorProtocol,ActivityImagesProtocol {
    var activityType: Int
    var levelType: Int
    
    var userId : String
    var classId : String
    var className : String
    var classImage : String
    var classDate : Int64
    var classTime : Int64
    var classHour : Int
    var numberofPeople : Int
    var price : Double
    var timeStamp : Int64 = Date().toMillis()
    var orderId : String = ""
    var authorId : String = ""
    var profile : String = ""
    var name : String = ""
    
    init(userid: String, classId : String,className : String, classImage : String, classDate : Date, classTime : Int64, classHour : Int, numberofPeople : Int,price : Double,
         activityType: Int, levelType: Int, authorId: String ) {
        self.userId = userid
        self.classId = classId
        self.className = className
        self.classImage = classImage
        self.classDate = classDate.toMillis()
        self.classTime = classTime
        self.classHour = classHour
        self.numberofPeople = numberofPeople
        self.price = price
        self.activityType = activityType
        self.levelType = levelType
        self.authorId = authorId
    }
    
    
}

extension BookingModel {
    
    init?(value: [String : AnyObject]){
        print("\(value)")
        self.userId = value["userId"] as! String
        self.classId = value["classId"] as! String
        self.className = value["className"] as? String ?? ""
        self.classImage = value["classImage"] as! String
        self.classDate = value["classDate"] as! Int64
        self.classTime = value["classTime"] as! Int64
        self.classHour = value["classHour"] as! Int
        self.numberofPeople = value["numberofPeople"] as! Int
        self.price = value["price"] as! Double
        self.timeStamp = value["timeStamp"] as? Int64 ?? Date().toMillis()
        self.orderId = value["orderId"] as? String ?? ""
        self.activityType = value["activityType"] as! Int
        self.levelType = value["levelType"] as! Int
        self.orderId = value["orderId"] as! String
        self.authorId = value["authorId"] as? String ?? ""
        self.profile = value["profile"] as? String ?? ""
        self.name = value["name"] as? String ?? ""
    }
    
    static func getBookingModels(data : Dictionary<String,AnyObject>) -> [BookingModel]{
//        var array = [BookingModel]()
        
        let  array  = data.map { (key, value)  in
            BookingModel(value : value as! [String : AnyObject]  )
        }

        return array as! [BookingModel]
    }
}
