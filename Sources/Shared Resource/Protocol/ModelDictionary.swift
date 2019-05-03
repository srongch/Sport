//
//  ModelDictionary.swift
//  User
//
//  Created by Chhem Sronglong on 23/04/2019.
//  Copyright © 2019 100456065. All rights reserved.
//

import Foundation

protocol ModelDictionary {
    var asDictionary : [String:Any] {get}
}

extension ModelDictionary{
        var asDictionary : [String:Any] {
            let mirror = Mirror(reflecting: self)
            let dict = Dictionary(uniqueKeysWithValues: mirror.children.lazy.map({ (label:String?,value:Any) -> (String,Any)? in
                guard label != nil else { return nil }
                return (label!,value)
            }).compactMap{ $0 })
            return dict
        }
    

}
