//
//  ReviewProtocol.swift
//  User
//
//  Created by Chhem Sronglong on 31/03/2019.
//  Copyright © 2019 100456065. All rights reserved.
//

import Foundation

protocol ReviewProtocol {
    var uid : String {get set}
    var timeStamp : Int64 {get set}
    var text : String {get set}
}
