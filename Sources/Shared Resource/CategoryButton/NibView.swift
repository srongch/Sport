//
//  NibView.swift
//  SportShare
//
//  Created by Chhem Sronglong on 02/03/2019.
//  Copyright © 2019 Chhem Sronglong. All rights reserved.
//

import UIKit

class NibView: UIView {
    var view: UIView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Setup view from .xib file
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Setup view from .xib file
        xibSetup()
    }
}
private extension NibView {
    
    func xibSetup() {
        backgroundColor = UIColor.clear
        view = loadNib()
        // use bounds not frame or it'll be offset
        view.frame = bounds
//            view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth,
//                                         UIView.AutoresizingMask.flexibleHeight]
        // Adding custom subview on top of our view
//        addSubview(view)
//        view.frame = self.bounds
//        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        addSubview(view)
        
//        view.translatesAutoresizingMaskIntoConstraints = false
//        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[childView]|",
//                                                      options: [],
//                                                      metrics: nil,
//                                                      views: ["childView": view]))
//        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[childView]|",
//                                                      options: [],
//                                                      metrics: nil,
//                                                      views: ["childView": view]))
    }
}
