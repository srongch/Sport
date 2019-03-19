//
//  DatePickerPopup.swift
//  Trainer
//
//  Created by Chhem Sronglong on 16/03/2019.
//  Copyright © 2019 100456065. All rights reserved.
//

import UIKit
import SwiftEntryKit

class DatePickerPopup: NibView {
    
    var onComplete: ((_ isCancel : Bool,_ result: String,_ date: Date)->())?

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
     @IBAction func datePickerValueChange(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
//        dateFormatter.dateStyle = DateFormatter.Style.short
//        dateFormatter.timeStyle = DateFormatter.Style.short
        
        let strDate = dateFormatter.string(from: datePicker.date)
//        dateLabel.text = strDate
        print("\(strDate)")
     }
    
    func formatDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        //        dateFormatter.dateStyle = DateFormatter.Style.short
        //        dateFormatter.timeStyle = DateFormatter.Style.short
        
        let strDate = dateFormatter.string(from: datePicker.date)
        //        dateLabel.text = strDate
        print("\(strDate)")
        return strDate
    }
    
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
    
    func xibSetup(){
        let calendar = Calendar.current
        
        var maxDateComponent = calendar.dateComponents([.day,.month,.year], from: Date())
//        maxDateComponent.day
//        maxDateComponent.month
        maxDateComponent.year = maxDateComponent.year! + 1
        
        let maxDate = calendar.date(from: maxDateComponent)
        print("max date : \(String(describing: maxDate))")
        
        datePicker.minimumDate = Date() as Date
        datePicker.maximumDate =  maxDate! as Date
    }
 
    
    @IBAction func closePressed(_ sender: Any) {
        SwiftEntryKit.dismiss()
    }
    
    @IBAction func donePressed(_ sender: Any) {
        print("done pressed")
        onComplete?(false,formatDate(), datePicker.date)
        SwiftEntryKit.dismiss()
    }
}
