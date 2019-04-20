//
//  AddClassNavi.swift
//  Trainer
//
//  Created by 100456065 on 08/03/2019.
//  Copyright © 2019 100456065. All rights reserved.
//

import UIKit

protocol AddClassNaviProtocol {
    func closeButtonDidPressed()
}

class AddClassNavi: NibView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var step: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    var delegate :  AddClassNaviProtocol?
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    @IBInspectable var naviTitle: String = "" {
        didSet {
            self.titleLabel.text = naviTitle
        }
    }

    @IBInspectable var naviStep: String = "" {
        didSet {
            self.step.text = naviStep
        }
    }
    
    @IBInspectable var buttonImage: UIImage = UIImage(named: "close_button")! {
        didSet{
            self.closeButton.setImage(buttonImage, for: .normal)
        }
    }
    
    @IBInspectable var hideButton : Bool = false {
        didSet {
            self.closeButton.isHidden = hideButton
        }
    }
    
    func setStep(stepNumber : Int) {
        step.text = "\(stepNumber)/5"
    }
    
    
    
    @IBAction func buttonPressed(_ sender: Any) {
        delegate?.closeButtonDidPressed()
    }
    
    
}
