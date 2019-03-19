//
//  AddClassDateSectionView.swift
//  Trainer
//
//  Created by Chhem Sronglong on 16/03/2019.
//  Copyright © 2019 100456065. All rights reserved.
//

import UIKit

protocol AddClassDateProtocol : class {
    func calenderButtonDidPressed (buttonType : DateButtonType )
}

class AddClassDateSectionView: UITableViewHeaderFooterView {

    @IBOutlet weak var fromDate: SelectDateView!
    @IBOutlet weak var toDate: SelectDateView!
    
    @IBOutlet weak var addDate: SelectDateView!
    
    @IBOutlet weak var monday: SelectDateView!
    @IBOutlet weak var tuesday: SelectDateView!
    @IBOutlet weak var wednesday: SelectDateView!
    @IBOutlet weak var thursday: SelectDateView!
    @IBOutlet weak var friday: SelectDateView!
    @IBOutlet weak var saturday: SelectDateView!
    @IBOutlet weak var sunday: SelectDateView!
    
    var daysArray : [SelectDateView] = []
    
    var classDay = Set<Int>()
    
    weak var addClassDateDelegate : AddClassDateProtocol?
    
    var viewModel : AddClassViewModel?
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    func setupView (delegate : AddClassDateProtocol, model : AddClassViewModel?){
        
        addClassDateDelegate = delegate
        viewModel = model
        
        
        fromDate.setType(buttonType : .calendar_start, delegate : self)
        toDate.setType(buttonType : .calendar_end, delegate : self)
        
        addDate.setType(buttonType : .time, delegate : self)
        
        monday.setTypeForDayofWeek(buttonType : .dayofWeek, delegate : self, tag: 0)
        tuesday.setTypeForDayofWeek(buttonType : .dayofWeek, delegate : self, tag: 1)
        wednesday.setTypeForDayofWeek(buttonType : .dayofWeek, delegate : self, tag: 2)
        thursday.setTypeForDayofWeek(buttonType : .dayofWeek, delegate : self, tag: 3)
        friday.setTypeForDayofWeek(buttonType : .dayofWeek, delegate : self, tag: 4)
        saturday.setTypeForDayofWeek(buttonType : .dayofWeek, delegate : self, tag: 5)
        sunday.setTypeForDayofWeek(buttonType : .dayofWeek, delegate : self, tag: 6)
        
        daysArray = [monday,tuesday,wednesday,thursday,friday,saturday,sunday]
        setupViewFromModel()
    }
    
    func setupViewFromModel() {
        self.setFromDate(dateText: (viewModel?.classModel?.startDateString)!, date: nil)
        self.setTodate(dateText: (viewModel?.classModel?.endDateString)!, date: nil)
        
        self.classDay = viewModel?.classModel?.dayoftheWeek ?? []
        
        for  temp : SelectDateView in daysArray {
            print("buton tag is \(temp.button.tag)")
            if ((viewModel?.classModel?.dayoftheWeek.contains(temp.button.tag))!){
                temp.setButtonPressed(isSelected: true)
                print("selected")
            }else{
                print("unselected")
              //  temp.setButtonPressed(isSelected: false)
            }
        }
    }
    
    func setTodate(dateText :String, date : Date?) {
        toDate.textLabel.text = dateText
        guard let temp = date else {
            return
        }
        viewModel?.endDate = temp
    }
    
    func setFromDate(dateText :String, date : Date?){
         fromDate.textLabel.text = dateText
        guard let temp = date else {
            return
        }
        viewModel?.startDate = temp
    }
    
    
}

extension AddClassDateSectionView : SelectDateViewProtocol{
    func daysDidPressed(dayIndex: Int, isAdd : Bool) {
        if (isAdd) {
            classDay.insert(dayIndex)
        }else{
            classDay.remove(dayIndex)
        }
        viewModel?.classModel?.dayoftheWeek = classDay
        print("\(classDay)")
    }
    
    func dateViewDidPressed(buttonType: DateButtonType) {
        print("Button pressed")
        
        if ((buttonType == .calendar_end || buttonType == .calendar_start || buttonType == .time) && addClassDateDelegate != nil){
            addClassDateDelegate?.calenderButtonDidPressed(buttonType: buttonType)
        }
        
    }
    
    
}
