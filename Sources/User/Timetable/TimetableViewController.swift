//
//  TimetableViewController.swift
//  User
//
//  Created by Chhem Sronglong on 20/03/2019.
//  Copyright © 2019 100456065. All rights reserved.
//

import UIKit

class TimetableViewController: UIViewController {

    @IBOutlet weak var menuView: TimetableMenuView!
    @IBOutlet weak var scheduleCollectionView: UICollectionView!
    
    @IBOutlet weak var monthButton: UIButton!
    @IBOutlet weak var yearButton: UIButton!
    @IBOutlet weak var noDataLabel: UILabel!
    
    lazy private var notLoginVC = NotLoginViewController.instance()
    lazy private var loadingVC = LoadingViewController.instance(self.view.frame)
    
    var dataService : TimeTableCoreData?
    var selectIndex : Int = 0
    var isNotLoginCurrentShow = false
    
    
    var isViewIsFirst = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupCollectionView()
        menuView.setDidSelectItemClosure { [weak self] indexPath in
            self?.selectIndex = indexPath.row
            self?.scheduleCollectionView.reloadData()
        }
        
        isViewIsFirst = true
        self.validateView()
        self.setupHeader()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if (!isViewIsFirst){
           validateView()
        }else{
            isViewIsFirst = false
        }
    }
    
    func setupHeader(){
        
        monthButton.setTitle(Date().toMillis()?.toDateWithFormate(format: "MMMM"), for: .normal)
        yearButton.setTitle(Date().toMillis()?.toDateWithFormate(format: "YYYY"), for: .normal)
    }
    
    func validateView(){
        if UserService.shared.isHaveUser {
            notLoginVC.remove()
            isNotLoginCurrentShow = false
            self.loadData()
        }else{
            self.showNotLogin()
        }
    }
    
    func showNotLogin(){
//        notLoginVC = NotLoginViewController.instance()
        if isNotLoginCurrentShow == false { add(notLoginVC)}
        isNotLoginCurrentShow = true
    }
    
    func loadData(){
        add(loadingVC)
        dataService = TimeTableCoreData(userId: UserService.shared.globalUser?.uid, delegate : self)
        //        dataService?.delegate = self
        print("user is : \(UserService.shared.globalUser?.uid)")
    }
    
    func setupCollectionView(){
        self.scheduleCollectionView.dataSource = self
        self.scheduleCollectionView.delegate = self
        self.scheduleCollectionView.register(UINib(nibName: "ScheduleCell", bundle: nil), forCellWithReuseIdentifier: "ScheduleCell")
    }
    
    @IBAction func monthPressed(_ sender: Any) {
        let controller = ArrayChoiceTableViewController(Months.allMonths) { (direction) in
            //            self.model.direction = direction
            self.monthButton.setTitle(direction.rawValue, for: .normal)
            self.dataService?.filterData(month : direction.rawValue, year : self.yearButton.title(for: .normal)!)
            print("\(direction) clicked.")
        }
        controller.preferredContentSize = CGSize(width: 150, height: 200)
        showPopup(controller, sourceView: sender as! UIView)
    }
    
    @IBAction func yearPressed(_ sender: Any) {
        let controller = ArrayChoiceTableViewController(Years.allyears) { (direction) in
//            self.model.direction = direction
            print("\(direction) clicked.")
            self.yearButton.setTitle(direction, for: .normal)
            self.dataService?.filterData(month : self.monthButton.title(for: .normal)! , year : direction)
        }
        controller.preferredContentSize = CGSize(width: 100, height: 200)
        showPopup(controller, sourceView: sender as! UIView)
    }
    
    
    private func showPopup(_ controller: UIViewController, sourceView: UIView) {
        let presentationController = AlwaysPresentAsPopover.configurePresentation(forController: controller)
        presentationController.sourceView = sourceView
        presentationController.sourceRect = sourceView.bounds
        presentationController.permittedArrowDirections = [.down, .up]
        self.present(controller, animated: true)
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

extension TimetableViewController : UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataService?.getDetailDataByIndex(index:selectIndex)?.details.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ScheduleCell = self.scheduleCollectionView.dequeueReusableCell(withReuseIdentifier: "ScheduleCell", for: indexPath) as! ScheduleCell
//
//        let classRegister = ClassRegistration(level: Int.random(in: 0...2), activity : Int.random(in: 0...5))
        
        cell.setupCell(model : dataService!.getDetailDataByIndex(index: selectIndex)!.details[indexPath.row])
//        cell.setupView(isSelected: selectedIndexPath == indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:self.view.frame.size.width, height:80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 5, right:0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    
    
}

extension TimetableViewController : TitmeTableProtocol {
    func timeTableDidUpdate(data: [TimeTableDate]){
        loadingVC.remove()
        noDataLabel.isHidden = data.count > 0
        self.menuView.setDataSource(data: data)
    }
}


extension TimetableViewController {
    
    static func instance ()-> UINavigationController {
        return UIStoryboard.storyboard(.timetable).instantiateViewController(withIdentifier:"TimeTableNavigation") as! UINavigationController
    }
}

