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


struct ClassModel : ModeltoDictionaryProtocol, LevelColorProtocol {
    var key : String = ""
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
    var rating : Double = 0
    var reviews : Int = 0
    var authorId : String = ""
    var authorName : String = ""
    var authorDesc : String = ""
    
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
       // print(value)
        
        guard  let value = snapshot.value as? [String:AnyObject] else {
            print("no value")
            return nil
        }
        setupData(value: value,key: snapshot.key)
    }
    
    init?(value : [String:AnyObject], key : String ) {
        setupData(value: value, key: key)
    }
    
    mutating func setupData(value : [String:AnyObject] , key : String?){
        guard  let ratingValue = value["rating"] as? Double else {
            print("no rating value")
            return
        }
        //
        guard
            
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

extension ClassModel {
    
//    // 3
//    for child in snapshot.children {
//    // 4
//    if let snapshot = child as? DataSnapshot,
//    let groceryItem = GroceryItem(snapshot: snapshot) {
//    newItems.append(groceryItem)
//    }
//    }
    
    static func classModelFromArray(snapshot: DataSnapshot)-> [ClassModel]? {
        guard let dictionary = snapshot.value as? [String:Any] else {return nil}
        
        var classArray = [ClassModel]()
        
         for child in snapshot.children {
            if let snapshot = child as? DataSnapshot,
             let model = ClassModel(snapshot: snapshot) {
                classArray.append(model)
          }
        }
        
        return classArray
    }
    
   static func getclassModels(data : Dictionary<String,AnyObject>) -> [ClassModel]{
        //        var array = [BookingModel]()
        
        let  array  = data.map { (key, value)  in
            ClassModel(value : value as! [String : AnyObject], key: key  )
        }
        
        return array as! [ClassModel]
    }
    
    var getImageFromArray: String {
        get {
            return self.imageArray[0]
            
        }
    }
    
}
