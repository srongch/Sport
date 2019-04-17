//
//  ProfileState.swift
//  User
//
//  Created by Chhem Sronglong on 06/04/2019.
//  Copyright © 2019 100456065. All rights reserved.
//

import Foundation

struct ProfileState : Codable {
    var booking_count : Int
    var like_count : Int
}

extension ProfileState {
  static func parse(from data: Any) -> ProfileState {
    let decoder = JSONDecoder()
    let jsonData = try! JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
    let model = try! decoder.decode(self, from: jsonData)
    return model
    }
}
