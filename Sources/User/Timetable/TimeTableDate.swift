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
        self.month = timeTable.date.toDateWithFormate(format: "MM")
        self.day = timeTable.date.toDateWithFormate(format: "dd")
        self.year = timeTable.date.toDateWithFormate(format: "YYYY")
        self.dayoftheWeek = timeTable.date.toDateWithFormate(format: "E")
        self.details = [timeTable]
    }
    
    mutating func addTimeTable(timeTable : TimeTable) {
        self.details.append(timeTable)
    }
    
    func isTheSameDate(date : Int64) -> Bool{
        return date.toDateWithFormate(format: "MMddYYYY") == "\(month)\(day)\(year)"
    }
}
