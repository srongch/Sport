//
//  Notification.swift
//  User
//
//  Created by Chhem Sronglong on 23/04/2019.
//  Copyright © 2019 100456065. All rights reserved.
//

import Foundation

struct Notification {
    var title : String
    
    var categoryIdentifire : String
    var identifier : String
    var date : Int64
    var time : Int64
    var name : String
    
    var body : String {
        get {
            return "\(self.name) starts on \(self.dateString)"
        }
    }
    
    var dateString: String {
        get {
            return "\(date.toDateWithFormate(format: "MM-dd-YYYY")) \(time.toDateWithFormate(format: "HH:ss"))"
        }
    }
    
    var scheduleDate: DateComponents?{
        
        guard let schedule = self.dateString.convertToDate(withFormat: "MM-dd-YYYY HH:ss") else{
            return nil
        }
        
        print(dateString)
        print(schedule)
        
        let triggerDate = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second,], from: schedule)
        return triggerDate
        
    }
}

extension Notification {
    init(bookingModel : BookingModel) {
        self.title = "You have class schedule today."
        self.categoryIdentifire = "booking"
        self.identifier = "local_noti_\(UUID().uuidString)"
        self.date = bookingModel.classDate
        self.time = bookingModel.classTime
        self.name = bookingModel.className
    }
}
