//
//  ColorExtension.swift
//  SportShare
//
//  Created by Chhem Sronglong on 01/03/2019.
//  Copyright © 2019 Chhem Sronglong. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    static var blueColor: UIColor  { return UIColor(red: 53.0/255, green: 59.0/255, blue: 80.0/255, alpha: 1.0) }
    static var secondColor: UIColor { return UIColor(red: 0, green: 1, blue: 0, alpha: 1) }
    
    static var calender_grey_color : UIColor{ return UIColor(red: 113.0/255, green: 116.0/255, blue: 127.0/255, alpha: 1) }
    
}

extension UIFont {
    private static func customFont(name: String, size: CGFloat) -> UIFont {
        let font = UIFont(name: name, size: size)
        assert(font != nil, "Can't load font: \(name)")
        return font ?? UIFont.systemFont(ofSize: size)
    }
    
    static func mainFont(ofSize size: CGFloat) -> UIFont {
        return customFont(name: "FiraSans-Bold", size: size)
    }
}

extension Date {
    func toMillis() -> Int64! {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
}
