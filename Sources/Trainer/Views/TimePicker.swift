//
//  TimePicker.swift
//  Trainer
//
//  Created by Chhem Sronglong on 16/03/2019.
//  Copyright © 2019 100456065. All rights reserved.
//

import UIKit
import SwiftEntryKit

class TimePicker: NibView {

    var onComplete: ((_ isCancel : Bool,_ result: String,_ duration: Int,_ date: Date)->())?
    
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var durationPicker: UIPickerView!

    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    
    var durationSelected : Int = 1
    
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
    @IBAction func closeButton(_ sender: Any) {
        SwiftEntryKit.dismiss()
    }
    @IBAction func doneButton(_ sender: Any) {
        onComplete?(false, timeFormate(),durationSelected, timePicker.date)
        SwiftEntryKit.dismiss()
    }
    
    @IBAction func picketValueChange(_ sender: Any) {
    }
    
    func timeFormate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:MM"
        
        let strDate = dateFormatter.string(from: timePicker.date)
        //        dateLabel.text = strDate
        print("\(strDate)")
        return strDate
    }
    
    
}

extension TimePicker : UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 12
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row + 1) hours"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("select row : \(row)")
        durationSelected = row
        
    }
}
