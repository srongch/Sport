//
//  SelectDateView.swift
//  Trainer
//
//  Created by Chhem Sronglong on 16/03/2019.
//  Copyright © 2019 100456065. All rights reserved.
//

import UIKit

enum DateButtonType {
    case calendar_start
    case calendar_end
    case dayofWeek
    case time
}

protocol SelectDateViewProtocol: class {
    func dateViewDidPressed(buttonType : DateButtonType)
    func daysDidPressed(dayIndex : Int, isAdd : Bool)
}

class SelectDateView: NibView {

    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    
    weak var dateViewDelegate : SelectDateViewProtocol?
    
    var buttonType : DateButtonType = .calendar_start
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    func setType (buttonType : DateButtonType, delegate : SelectDateViewProtocol){
        self.buttonType = buttonType
        dateViewDelegate = delegate
    }
    
    func setTypeForDayofWeek (buttonType : DateButtonType, delegate : SelectDateViewProtocol, tag : Int){
        self.buttonType = buttonType
        dateViewDelegate = delegate
        button.tag = tag
    }
    
    
    @IBInspectable var text: String = "" {
        didSet {
            self.textLabel.text = text
        }
    }
    
    @IBInspectable var image: UIImage = UIImage(named: "calendar")! {
        didSet{
            self.iconImage.image = image
        }
    }
    
    @IBInspectable var backgroundcolor: UIColor = UIColor.white {
        didSet{
            self.view.backgroundColor = backgroundcolor
        }
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        switch buttonType {
        case .dayofWeek:
            button.isSelected = !button.isSelected
            iconImage.image = button.isSelected ? UIImage(named: "check_box_checked") :  UIImage(named: "check_box")
            dateViewDelegate?.daysDidPressed(dayIndex: button.tag, isAdd: button.isSelected )
        default:
            break
        }
        
        guard (dateViewDelegate != nil) else {
            return
        }
        dateViewDelegate?.dateViewDidPressed(buttonType: buttonType)
        
    }
    
    func setButtonPressed (isSelected : Bool){
        button.isSelected = isSelected
        iconImage.image = button.isSelected ? UIImage(named: "check_box_checked") :  UIImage(named: "check_box")
      //  dateViewDelegate?.daysDidPressed(dayIndex: button.tag, isAdd: button.isSelected )
    }
    
    
    

}
