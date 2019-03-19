//
//  CalenderViewController.swift
//  User
//
//  Created by 100456065 on 19/03/2019.
//  Copyright © 2019 100456065. All rights reserved.
//

import UIKit
import JTAppleCalendar

class CalenderViewController: UIViewController {

    @IBOutlet weak var calenderView: JTAppleCalendarView!
    
    @IBOutlet weak var monthText: UILabel!
    @IBOutlet weak var nextMonth: UIButton!
    @IBOutlet weak var previousMonth: UIButton!
    
    let formatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupCalenderView()

        // Do any additional setup after loading the view.
    }
    
    func setupCalenderView (){
        calenderView.ibCalendarDelegate = self
        calenderView.ibCalendarDataSource = self
        calenderView.minimumLineSpacing = 0
        calenderView.minimumInteritemSpacing = 0
        calenderView.visibleDates{ visibleDates in
            self.handleMonthChange(from: visibleDates)
        }
        
    }
    
    func handleCelltextColor (cell : JTAppleCell?, cellState : CellState){
        guard let cell : CustomCalenderCell = cell as? CustomCalenderCell else{return}
        if (cellState.isSelected) {
            cell.textLabel.textColor = UIColor.white
        }else{
            if (cellState.dateBelongsTo == .thisMonth){
                cell.textLabel.textColor = UIColor.blueColor
            }else{
                cell.textLabel.textColor = UIColor.calender_grey_color
            }
        }
    }
    
    func handleCellBackgroundColor (cell : JTAppleCell?, cellState : CellState, date : Date){
        guard let cell : CustomCalenderCell = cell as? CustomCalenderCell else{return}
        if (cellState.isSelected) {
            cell.selectedView.backgroundColor = UIColor.blueColor
            cell.stripView.isHidden = true
        }else{
            cell.selectedView.backgroundColor = UIColor.white
            cell.stripView.isHidden = true
        }
    }
    
    func handleMonthChange (from visibleDates : DateSegmentInfo){
        let tempdate  = visibleDates.monthDates.first!.date
        formatter.dateFormat = "MMMM YYYY"
        monthText.text = formatter.string(from: tempdate)
    }
    
    func handleCalendarScroll(cellState : CellState){
        if cellState.dateBelongsTo == .followingMonthWithinBoundary {
             calenderView.scrollToSegment(.next)
        }else if cellState.dateBelongsTo == .previousMonthWithinBoundary{
            calenderView.scrollToSegment(.previous)
        }
       
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CalenderViewController : JTAppleCalendarViewDelegate, JTAppleCalendarViewDataSource{
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        // This function should have the same code as the cellForItemAt function
        let myCustomCell = cell as! CustomCalenderCell
        sharedFunctionToConfigureCell(myCustomCell: myCustomCell, cellState: cellState, date: date)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let myCustomCell = calendar.dequeueReusableCell(withReuseIdentifier: "CustomCalenderCell", for: indexPath) as! CustomCalenderCell
        sharedFunctionToConfigureCell(myCustomCell: myCustomCell, cellState: cellState, date: date)
        return myCustomCell
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        handleCellBackgroundColor(cell: cell, cellState: cellState, date: date)
        handleCelltextColor(cell: cell, cellState: cellState)
        handleCalendarScroll(cellState: cellState)
        
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        handleCellBackgroundColor(cell: cell, cellState: cellState, date: date)
        handleCelltextColor(cell: cell, cellState: cellState)
    }
    
    func sharedFunctionToConfigureCell(myCustomCell: CustomCalenderCell, cellState: CellState, date: Date) {
        myCustomCell.textLabel.text = cellState.text
        handleCellBackgroundColor(cell: myCustomCell, cellState: cellState, date: date)
        handleCelltextColor(cell: myCustomCell, cellState: cellState)
        
//        if testCalendar.isDateInToday(date) {
//            myCustomCell.backgroundColor = red
//        } else {
//            myCustomCell.backgroundColor = white
//        }
        // more code configurations
        // ...
        // ...
        // ...
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        handleMonthChange (from: visibleDates)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, shouldSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) -> Bool {
        return true
    }
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        
        formatter.dateFormat = "yyyy MM dd"
        formatter.timeZone = Calendar.current.timeZone
        formatter.locale = Calendar.current.locale
        
        let startDate = formatter.date(from: "2017 01 01")!
        let endDate = formatter.date(from: "2017 12 01")!
        
        let parameter = ConfigurationParameters(startDate: startDate, endDate: endDate)
        return parameter
    }
}


