//
//  ProfileSetting.swift
//  User
//
//  Created by Chhem Sronglong on 29/03/2019.
//  Copyright © 2019 100456065. All rights reserved.
//

import Foundation

enum SettingType : String{
    
    case editProfile
    case favorite
    case payment
    
}

struct Setting {
   var text : String
    var settingType : SettingType
    
    init(text : String,type : SettingType) {
        self.text = text
        self.settingType = type
    }
}

extension Setting {
   static func getSettingArray(isUser : Bool, isLogin : Bool)-> [Setting]{
        var array = [Setting]()
        if (isLogin){
            array.append(Setting(text: "Edit Profile", type: .editProfile))
        }
        
        if (isUser) {
            array.append(Setting(text: "Favorite", type: .favorite))
             array.append(Setting(text: "Payment", type: .payment))
        }else{
            // is for trainer
        }
        return array
    }
}
