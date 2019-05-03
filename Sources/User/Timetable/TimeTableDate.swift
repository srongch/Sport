//
//  TimeTableDate.swift
//  User
//
//  Created by Chhem Sronglong on 09/04/2019.
//  Copyright © 2019 100456065. All rights reserved.
//

import Foundation

struct TimeTableDate {
    var month : String
    var year : String
    var day : String
    var dayoftheWeek : String
    var details : [TimeTable]
    
}

extension TimeTableDate {
    init(timeTable : TimeTable) {
        self.month = timeTable.date.toDateWithFormate(format: "MMMM")
        self.day = timeTable.date.toDateWithFormate(format: "dd")
        self.year = timeTable.date.toDateWithFormate(format: "YYYY")
        self.dayoftheWeek = timeTable.date.toDateWithFormate(format: "E")
        self.details = [timeTable]
    }
    
    mutating func addTimeTable(timeTable : TimeTable) {
        
        guard let index = self.details.index(where: {
            $0.title == timeTable.title && $0.time == timeTable.time
        }) else {
            print("different date on \(timeTable.title) && \(timeTable.time)")
//            self.details.append(timeTable)
            self.details.append(timeTable)
            return
        }
        
    }
    
    
    mutating func sort(){
      self.details = self.details.sorted(by: {$0.time > $1.time})
    }
    
    func isTheSameDate(date : Int64) -> Bool{
        return date.toDateWithFormate(format: "MMMMddYYYY") == "\(month)\(day)\(year)"
    }
    
    func getDate()->String{
       return "\(month)\(day)\(year)"
    }
}
