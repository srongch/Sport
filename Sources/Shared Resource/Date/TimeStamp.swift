//
//  TimeStamp.swift
//  User
//
//  Created by 100456065 on 19/03/2019.
//  Copyright © 2019 100456065. All rights reserved.
//

import Foundation

extension Int64 {
    func toDateWithFormate(formate: String) -> String {
        return ""
    }
    
    func toDate() -> Date{
       return Date(timeIntervalSince1970: TimeInterval(self / 1000))
    }
}


