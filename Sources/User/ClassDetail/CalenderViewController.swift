//
//  CalenderViewController.swift
//  User
//
//  Created by 100456065 on 19/03/2019.
//  Copyright © 2019 100456065. All rights reserved.
//

import UIKit
import JTAppleCalendar

class CalenderViewController: UIViewController,NaviBarProtocol {

    
    @IBOutlet weak var naviBar: NaviBar!
    @IBOutlet weak var calenderView: JTAppleCalendarView!
    @IBOutlet weak var timeViewWrapperieghtConstrain: NSLayoutConstraint!
    
    @IBOutlet weak var monthText: UILabel!
    @IBOutlet weak var nextMonth: UIButton!
    @IBOutlet weak var previousMonth: UIButton!
    
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var numberLabel: UILabel!
    
    @IBOutlet weak var timeCollectionView: UICollectionView!
    private let itemsPerRow: CGFloat = 3
    private let sectionInsets = UIEdgeInsets(top: 0.0,
                                             left: 10.0,
                                             bottom: 0.0,
                                             right: 10.0)
    
    var classModel : ClassModel?
    var selectDate : Date?
    var selectTime : Int?
    var numberofPerson : Int = 0
    
    let formatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupCalenderView()
        self.setupCollectionView()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if (classModel!.times.count < Int(itemsPerRow)){
            timeViewWrapperieghtConstrain.constant = 60
        }else{
        timeViewWrapperieghtConstrain.constant =  (CGFloat(classModel!.times.count)/CGFloat(itemsPerRow)) * 60
        }
    }
    
    func setupCollectionView(){
        timeCollectionView.delegate = self
        timeCollectionView.dataSource = self
        naviBar.delegate = self
    }
    
    func buttonBackPressed() {
        self.navigationController?.popViewController(animated: true)
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
    
    func handleCelltextColor (cell : JTAppleCell?, cellState : CellState, date : Date){
        guard let cell : CustomCalenderCell = cell as? CustomCalenderCell else{return}
        if (cellState.isSelected) {
            cell.textLabel.textColor = UIColor.white
        }else{
            if (cellState.dateBelongsTo == .thisMonth){
                cell.textLabel.textColor = UIColor.blueColor
                
                guard let model = classModel else {
                    return
                }
                let isEnable = date.isInTheRage(model.startDate.toDate(), model.endDate.toDate(), model.dayoftheWeek)
                cell.textLabel.textColor = isEnable ?  UIColor.blueColor :  UIColor.calender_grey_color
                
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
            
            guard let model = classModel else {
                cell.selectedView.backgroundColor = UIColor.white
                cell.stripView.isHidden = true
                return
            }
            let isEnable = date.isInTheRage(model.startDate.toDate(), model.endDate.toDate(), model.dayoftheWeek)
            cell.selectedView.backgroundColor = UIColor.white
            cell.stripView.isHidden = isEnable
            
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
    
    @IBAction func leftPressed(_ sender: Any) {
        self.calenderView.scrollToSegment(.previous)
    }
    
    @IBAction func rightPressed(_ sender: Any) {
        self.calenderView.scrollToSegment(.next)
    }
    
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        switch sender {
        case minusButton:
            numberofPerson = numberofPerson <= 1 ? 0 : numberofPerson - 1
        default:
            numberofPerson = numberofPerson <= 10 ? numberofPerson + 1 : numberofPerson
        }
        numberLabel.text = "\(numberofPerson)"
    }
    
    @IBAction func bookButtonPressed(_ sender: Any) {
        print("book button pressed")
        guard let selectedDate = self.selectDate  else{
            print("date not selected")
            presentAlertView(with: "Select a date.", isOneButton: true, onDone: {}, onCancel: {})
            return
        }
        
        guard let selectedTime = self.selectTime else {
            presentAlertView(with: "Select a time.", isOneButton: true, onDone: {}, onCancel: {})
            return
        }
        
        if (self.numberofPerson <= 0){
            presentAlertView(with: "Select number of people.", isOneButton: true, onDone: {}, onCancel: {})
            return
        }
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//         Get the new view controller using segue.destination.
//         Pass the selected object to the new view controller.
        
        if (segue.identifier == "comfirmbookingseque"){
            print("ready to go")
            let vc = segue.destination as! ConfirmBookingViewController
            vc.bookingModel = BookingModel(userid: UserService.shared.globalUser?.uid ?? "98tKelkTBGcaQOG5157Q2Lv5mgm2",
                                           classId: classModel!.key, className: classModel!.className, classImage: classModel!.imageArray[0],
                                           classDate: self.selectDate!,
                                           classTime: (self.classModel?.times[self.selectTime!])!,
                                           classHour: (self.classModel?.hours[self.selectTime!])!,
                                           numberofPeople: numberofPerson,
                                           price: self.classModel!.classPrice,
                                           activityType: classModel!.activityType,
                                           levelType: classModel!.levelType,authorId: self.classModel!.authorId)
        }
        
        
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if (identifier == "comfirmbookingseque"){
            guard let selectedDate = self.selectDate  else{
                print("date not selected")
                presentAlertView(with: "Select a date.", isOneButton: true, onDone: {}, onCancel: {})
                return false
            }
            
            guard let selectedTime = self.selectTime else {
                presentAlertView(with: "Select a time.", isOneButton: true, onDone: {}, onCancel: {})
                return false
            }
            
            if (self.numberofPerson <= 0){
                presentAlertView(with: "Select number of people.", isOneButton: true, onDone: {}, onCancel: {})
                return false
            }
            
            return true
        }
        return false
    }
 

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
        handleCelltextColor(cell: cell, cellState: cellState,date: date)
        handleCalendarScroll(cellState: cellState)
        let isInRage = date.isInTheRage(classModel!.startDate.toDate(), classModel!.endDate.toDate(), classModel!.dayoftheWeek)
        print(isInRage ? "yes" : "no" )
        print("date of week : \(String(describing: date.dayNumberOfWeek()))")
        selectDate  = date
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        handleCellBackgroundColor(cell: cell, cellState: cellState, date: date)
        handleCelltextColor(cell: cell, cellState: cellState,date: date)
    }
    
    func sharedFunctionToConfigureCell(myCustomCell: CustomCalenderCell, cellState: CellState, date: Date) {
        myCustomCell.textLabel.text = cellState.text
        handleCellBackgroundColor(cell: myCustomCell, cellState: cellState, date: date)
        handleCelltextColor(cell: myCustomCell, cellState: cellState,date: date)

    }
    
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        handleMonthChange (from: visibleDates)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, shouldSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) -> Bool {
        
        guard let model = classModel else {
            return false
        }
        return date.isInTheRage(model.startDate.toDate(), model.endDate.toDate(), model.dayoftheWeek)
    }
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        
        formatter.dateFormat = "yyyy MM dd"
        formatter.timeZone = Calendar.current.timeZone
        formatter.locale = Calendar.current.locale
        
        let startDate = formatter.date(from: "2017 01 01")!
        let endDate = formatter.date(from: "2017 12 01")!
        
       
        
        guard let model = classModel else{
            let parameter = ConfigurationParameters(startDate: startDate, endDate: endDate)
            return parameter
        }
        
        print("start date is : \(model.startDate.toDate())")
        print("end date is : \(model.endDate.toDate())")
        print("date of week : \(String(describing: model.endDate.toDate().dayNumberOfWeek()))")
        let parameter = ConfigurationParameters(startDate: Date(), endDate: model.endDate.toDate())
        return parameter
        
        
        
    }
}


extension CalenderViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return classModel?.times.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectTimesCollectionViewCell",
                                                      for: indexPath) as! SelectTimesCollectionViewCell

        
        guard let time = classModel else {
            return cell
        }
        
        let timeStr = time.times[indexPath.row].toDate().timeFromDate()
        
        cell.textLabel.text = "\(timeStr) - \(time.hours[indexPath.row]) hour\(time.hours[indexPath.row] == 1 ? "" : "s")"
        
        if(indexPath.row == selectTime){
            cell.wrapView.layer.borderWidth = 1
            cell.wrapView.layer.borderColor = UIColor.blueColor.cgColor
//           cell.wrapView.backgroundColor = UIColor.blueColor
//           cell.textLabel.textColor = UIColor.white
        }else{
            cell.wrapView.layer.borderWidth = 0
//            cell.wrapView.backgroundColor = UIColor.white
//            cell.textLabel.textColor = UIColor.blueColor
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let time = classModel else {
            return 
        }
        selectTime = indexPath.row
        timeCollectionView.reloadData()
    }

}

extension CalenderViewController : UICollectionViewDelegateFlowLayout{
    //1
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        //2
        let paddingSpace = sectionInsets.left * (itemsPerRow)
        let availableWidth = view.frame.width - 10 - 10 - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: 40)
    }
    
    //3
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    // 4
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}


