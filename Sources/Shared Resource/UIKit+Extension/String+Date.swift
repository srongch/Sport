//
//  String+Date.swift
//  User
//
//  Created by Chhem Sronglong on 23/04/2019.
//  Copyright © 2019 100456065. All rights reserved.
//

import Foundation

extension String {
    func convertToDate(withFormat: String)->Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = withFormat
        let s = dateFormatter.date(from: self)
        return s
    }
}
