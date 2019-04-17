//
//  TimeTable+CoreDataProperties.swift
//  
//
//  Created by Chhem Sronglong on 09/04/2019.
//
//

import Foundation
import CoreData


extension TimeTable :  LevelColorProtocol, ActivityImagesProtocol{
    var activityType: Int {
        get {
            return Int(self.activity)
        }
        set{
            
        }
    }
    
    var levelType: Int {
        get {
            return Int(self.level)
        }
        
        set{
            
        }
    }
    

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TimeTable> {
        return NSFetchRequest<TimeTable>(entityName: "TimeTable")
    }

    @NSManaged public var title: String?
    @NSManaged public var location: String?
    @NSManaged public var level: Int16
    @NSManaged public var time: Int64
    @NSManaged public var date : Int64
    @NSManaged public var activity : Int16

}
