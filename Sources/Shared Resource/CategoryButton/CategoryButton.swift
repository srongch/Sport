//
//  CategoryButton.swift
//  SportShare
//
//  Created by Chhem Sronglong on 01/03/2019.
//  Copyright © 2019 Chhem Sronglong. All rights reserved.
//
enum ButtonType {
    case workout
    case swimming
    case football
    case snowboarding
    case skiing
    case topRated
    
    var getTuple: (name: String, imageSelected: String, imageNormal: String, index: Int) {
        switch self {
        case .workout:
            return ("Workout", "workout_icon_blue","workout_icon_white", 0)
        case .swimming:
            return ("Swimming", "swimming_icon_blue","swimming_icon_white",1)
        case .football:
            return ("Football", "football_icon_blue","football_icon_white",2)
        case .snowboarding:
            return ("Snowboarding","snowboard_icon_blue","snowboard_icon_white",3)
        case .skiing:
            return ("Skiing","ski_icon_blue","ski_icon_white",4)
        case .topRated:
            return ("Top-Rated Activities","","",5)
        }
        
    }
}

enum ButtonSelectionStyle {
    case normal
    case flashSelection
}

protocol CategoryButtonPressedProtocol {
    func buttonDidPressed(buttonType: ButtonType)
}


import UIKit

//@IBDesignable
class CategoryButton: NibView {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var typeLabel: UILabel!

    @IBOutlet weak var button: UIButton!
    var buttonType : ButtonType = .workout
    var buttonSelectionStyle : ButtonSelectionStyle = .flashSelection
    var buttonDelegate : CategoryButtonPressedProtocol?
    
    @IBAction func buttonPressed(_ sender: Any) {
        if (button.isSelected) {
            clearButtonSelected()
        }else {
            setButtonSelected()
        }
        
        guard let delete = buttonDelegate else {
            print("No Deletgate")
            return
        }
        buttonDelegate?.buttonDidPressed(buttonType: buttonType)
    }
    
    
    
    func setButton(buttonType: ButtonType, selectionStyle : ButtonSelectionStyle, delegate : CategoryButtonPressedProtocol?  ){
         self.buttonType = buttonType
         icon.image = UIImage(named: buttonType.getTuple.imageSelected)
         typeLabel.text = buttonType.getTuple.name
         backgroundView.backgroundColor = UIColor.white
         buttonSelectionStyle = selectionStyle
        guard (delegate != nil) else {
            return
        }
        buttonDelegate = delegate
        
    }
    
    func setButtonSelected(){
        button.isSelected = true
        icon.image = UIImage(named: buttonType.getTuple.imageNormal)
        typeLabel.textColor = UIColor.white
        backgroundView.backgroundColor = UIColor.blueColor
        
        if buttonSelectionStyle == .flashSelection{
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.clearButtonSelected()
        }
        }
        
    }
    
    func clearButtonSelected(){
        button.isSelected = false
        icon.image = UIImage(named: buttonType.getTuple.imageSelected)
        typeLabel.textColor = UIColor.blueColor
        backgroundView.backgroundColor = UIColor.white
    }
    
}
//@IBDesignable
//class CategoryButton: UIView {
//
//    /*
//    // Only override draw() if you perform custom drawing.
//    // An empty implementation adversely affects performance during animation.
//    override func draw(_ rect: CGRect) {
//        // Drawing code
//    }
//    */
//    // Connect the custom button to the custom class
//    @IBOutlet weak var view: UIView!
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setup()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        setup()
//    }
//
//    func setup() {
//        view = loadViewFromNib()
//        view.frame = bounds
//
//        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth,
//                                 UIView.AutoresizingMask.flexibleHeight]
//
//        addSubview(view)
//
//        // Add our border here and every custom setup
//        view.layer.borderWidth = 2
//        view.layer.borderColor = UIColor.white.cgColor
////        view.titleLabel!.font = UIFont.systemFont(ofSize: 40)
//    }
//
//    func loadViewFromNib() -> UIView! {
//        let bundle = Bundle(for: type(of: self))
//        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
//        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
//
//        return view
//    }
//
//}
