//
//  UITableView+Extension.swift
//  User
//
//  Created by Chhem Sronglong on 02/04/2019.
//  Copyright © 2019 100456065. All rights reserved.
//

import UIKit


extension UITableView {
    
    // sums the height of visible cells
    func heightOfVisibleCells() -> CGFloat {
        return self.visibleCells.map({ $0.frame.height }).reduce(0, +)
    }
    
}
