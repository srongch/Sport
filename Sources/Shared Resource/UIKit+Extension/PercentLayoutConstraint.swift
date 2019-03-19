//
//  PercentLayoutConstraint.swift
//  SportShare
//
//  Created by Chhem Sronglong on 01/03/2019.
//  Copyright © 2019 Chhem Sronglong. All rights reserved.
//

import Foundation
import UIKit

/// Layout constraint to calculate size based on multiplier.
class PercentLayoutConstraint: NSLayoutConstraint {
    
    @IBInspectable var marginPercent: CGFloat = 0
    
    var screenSize: (width: CGFloat, height: CGFloat) {
        return (UIScreen.main.bounds.width, UIScreen.main.bounds.height)
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        guard marginPercent > 0 else { return }
        NotificationCenter.default.addObserver(self,
                                                         selector: #selector(layoutDidChange),
                                                         name: UIDevice.orientationDidChangeNotification,
                                                         object: nil)
    }
    
    /**
     Re-calculate constant based on orientation and percentage.
     */
    @objc func layoutDidChange() {
        guard marginPercent > 0 else { return }
        
        switch firstAttribute {
        case .top, .topMargin, .bottom, .bottomMargin:
            constant = screenSize.height * marginPercent
        case .leading, .leadingMargin, .trailing, .trailingMargin:
            constant = screenSize.width * marginPercent
        default: break
        }
    }
    
    deinit {
        guard marginPercent > 0 else { return }
        NotificationCenter.default.removeObserver(self)
    }
}
