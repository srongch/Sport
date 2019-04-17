//
//  TransactionModel.swift
//  Trainer
//
//  Created by Chhem Sronglong on 17/04/2019.
//  Copyright © 2019 100456065. All rights reserved.
//

import Foundation

struct Transactions {
    var fullDate : String
    var timeStamp : Int64
//    var month : String
//    var year : String
//    var day : String
//    var dayoftheWeek : String
    var details : [BookingModel]
    
}

extension Transactions {
    init(bookingModel : BookingModel) {
        self.fullDate = bookingModel.timeStamp.toDateWithFormate(format: "MMddYYYY")
        self.timeStamp = bookingModel.timeStamp
//        self.month = bookingModel.timeStamp.toDateWithFormate(format: "MM")
//        self.day = bookingModel.timeStamp.toDateWithFormate(format: "dd")
//        self.year = bookingModel.timeStamp.toDateWithFormate(format: "YYYY")
        self.details = [bookingModel]
    }
    
    mutating func addBooking(bookingModel : BookingModel) {
        self.details.append(bookingModel)
    }
    
    func isTheSameDate(date : Int64) -> Bool{
        return date.toDateWithFormate(format: "MMddYYYY") == fullDate
    }
    
    func getDateText()-> String{
        if Calendar.current.isDateInToday(timeStamp.toDate()) {
            return "Today"
        }
        
        if Calendar.current.isDateInYesterday(timeStamp.toDate()){
            return "Yesterday"
        }
        
        return timeStamp.toDateWithFormate(format: "MMMM dd")
        
    }
}
