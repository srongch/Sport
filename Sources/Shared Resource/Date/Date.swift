//
//  Date.swift
//  User
//
//  Created by 100456065 on 19/03/2019.
//  Copyright © 2019 100456065. All rights reserved.
//

import Foundation

extension Date {
    
    static let timeFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:ss"
        dateFormatter.isLenient = true
        return dateFormatter
    }()
    
    func isEqualTo(_ date: Date) -> Bool {
        return self == date
    }
    
    func isGreaterThan(_ date: Date) -> Bool {
        return self > date
    }
    
    func isSmallerThan(_ date: Date) -> Bool {
        return self < date
    }
    
    func isInTheRage(_ fromDate: Date, _ toDate: Date, _ dayOfTheWeek : [Int]) -> Bool{
        let isInRage = isGreaterThan(fromDate) && isSmallerThan(toDate)
        
        if isInRage {
            // 0 is Monday
            let dayArray = dayOfTheWeek.map { $0 + 1}
            return dayArray.contains(self.dayNumberOfWeek() ?? 0)
            
        }else{
            return isInRage
        }
        
    }
    
    func dayNumberOfWeek() -> Int? {
        return Calendar.current.dateComponents([.weekday], from: self).weekday
    }
    
    func timeFromDate() ->  String{
        return Date.timeFormatter.string(from: self)
    }
    
    
}
