//
//  UIView+StackView.swift
//  User
//
//  Created by Chhem Sronglong on 05/04/2019.
//  Copyright © 2019 100456065. All rights reserved.
//

import UIKit

extension UIView {
    
    func hideAnimated(in stackView: UIStackView) {
        if !self.isHidden {
            UIView.animate(
                withDuration: 0.2,
                delay: 0,
                usingSpringWithDamping: 0.9,
                initialSpringVelocity: 1,
                options: [],
                animations: {
                    self.isHidden = true
                    stackView.layoutIfNeeded()
            },
                completion: nil
            )
        }
    }
    
    func showAnimated(in stackView: UIStackView) {
        if self.isHidden {
            UIView.animate(
                withDuration: 0.2,
                delay: 0,
                usingSpringWithDamping: 0.9,
                initialSpringVelocity: 1,
                options: [],
                animations: {
                    self.isHidden = false
                    stackView.layoutIfNeeded()
            },
                completion: nil
            )
        }
    }
}
