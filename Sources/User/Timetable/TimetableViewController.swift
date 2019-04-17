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
    
    var dataService : TimeTableCoreData?
    var selectIndex : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupCollectionView()
        menuView.setDidSelectItemClosure { [weak self] indexPath in
            self?.selectIndex = indexPath.row
            self?.scheduleCollectionView.reloadData()
        }
        
        dataService = TimeTableCoreData(userId: UserService.shared.globalUser?.uid, delegate : self)
//        dataService?.delegate = self
        print("user is : \(UserService.shared.globalUser?.uid)")

        // Do any additional setup after loading the view.
    }
    
    func setupCollectionView(){
        self.scheduleCollectionView.dataSource = self
        self.scheduleCollectionView.delegate = self
        self.scheduleCollectionView.register(UINib(nibName: "ScheduleCell", bundle: nil), forCellWithReuseIdentifier: "ScheduleCell")
    }
    
    @IBAction func monthPressed(_ sender: Any) {
        let controller = ArrayChoiceTableViewController(Months.allMonths) { (direction) in
            //            self.model.direction = direction
            print("\(direction) clicked.")
        }
        controller.preferredContentSize = CGSize(width: 150, height: 200)
        showPopup(controller, sourceView: sender as! UIView)
    }
    
    @IBAction func yearPressed(_ sender: Any) {
        let controller = ArrayChoiceTableViewController(Years.allyears) { (direction) in
//            self.model.direction = direction
            print("\(direction) clicked.")
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
        
        let classRegister = ClassRegistration(level: Int.random(in: 0...2), activity : Int.random(in: 0...5))
        
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
        self.menuView.setDataSource(data: data)
    }
}


extension TimetableViewController {
    
    static func instance ()-> UINavigationController {
        return UIStoryboard.storyboard(.timetable).instantiateViewController(withIdentifier:"TimeTableNavigation") as! UINavigationController
    }
}

