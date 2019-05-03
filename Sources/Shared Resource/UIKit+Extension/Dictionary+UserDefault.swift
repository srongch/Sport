//
//  Dictionary+UserDefault.swift
//  User
//
//  Created by Chhem Sronglong on 23/04/2019.
//  Copyright © 2019 100456065. All rights reserved.
//

import Foundation

extension UserDefaults {
    // Retrieve dictionary for key
    open func dictionary(forKey key: String) -> [String: Any]? {
        let outData = UserDefaults.standard.data(forKey: key)
        let dict = NSKeyedUnarchiver.unarchiveObject(with: outData!)as? [String: Any]
        return dict
    }
    
    
}
