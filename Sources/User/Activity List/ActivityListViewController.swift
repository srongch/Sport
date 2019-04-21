//
//  ActivityListViewController.swift
//  SportShare
//
//  Created by Chhem Sronglong on 02/03/2019.
//  Copyright © 2019 Chhem Sronglong. All rights reserved.
//

import UIKit
import MapKit

class ActivityListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var naviTitle: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var beginner: UIButton!
    @IBOutlet weak var intermediate: UIButton!
    @IBOutlet weak var advance: UIButton!
    @IBOutlet weak var noDataLabel: UILabel!
    @IBOutlet weak var resetFilter: UIButton!
    
    let emptyView = EmptyViewController(caseType: .noDataList)
    
    var buttonArray : [UIButton]?
   
    var activityType : ButtonType = .swimming
    
    let classService = ClassService()
    var classArray : [ClassModel]?
    var filteredArray : [ClassModel]?
    var likeList : [UserLike]?
    
    //MARK: Filter Param
    var placeMark : MKPlacemark?
    var level : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        naviTitle.text = activityType.getTuple.name
        self.buttonArray = [beginner,intermediate,advance]
        
        classService.getClassByActivity(activity: activityType.getTuple.index) {classModel in
            guard let model = classModel else {return}
            self.classArray = model
            self.filteredArray = model
            self.tableView.reloadData()
        }
        
//        classArray.getuse
        if UserService.shared.isHaveUser {
            classService.getUserLikeClasses(userId: UserService.shared.globalUser?.uid ?? "") { classModels in
                
            }
        }
        
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func levelButtonPressed(_ sender: UIButton) {
     let isNeedFilter =  sender.setLevelButtonSelected(buttons: [beginner,intermediate,advance])
        print("level tag is : \(sender.tag) && isNeedFilter :\(isNeedFilter)")
        if isNeedFilter {
            level = sender.tag - 1
            self.filterList()
        }
    }
    
    @objc func likeButtonPressed(_ sender : UIButton){
        print("button tag is \(sender.tag)")
        
        guard let models = filteredArray else {
            return
        }
        
        let tempModel = models[sender.tag]
        classService.addUserLike(userId: UserService.shared.globalUser?.uid ?? "", classId: tempModel.key) { isError, operation in
        
            if isError {
                self.presentAlertView(with: "Operation Failed.", isOneButton: true, onDone: {}, onCancel: {})
                return
            }
            
            switch operation! {
            case "remove" :
            
                break
            default :
                
                break
            }
            
        }
    }
    
    @IBAction func resetPressed(_ sender: Any) {
        level = nil
        placeMark = nil
        locationLabel.text = "Select gym or sport places…"
        beginner.clearSelction(buttons: [beginner,intermediate,advance])
        filterList()
    }
    
    
    func filterList(){

        guard let filterList = classArray else{
            return
        }
        
        var filter = filterList
        
        if let level = self.level{
            filter = levelFilter(level: level,array: filter)
        }
        
        if let location = self.placeMark {
            filter = locationFilter(array: filter, place: location)
        }
    
        filteredArray = filter
        tableView.reloadData()
    }
    
    func levelFilter(level : Int, array : [ClassModel]) -> [ClassModel]{
      return array.filter({ model -> Bool in
            return model.levelType == level
        })
    }
    
    func locationFilter(array : [ClassModel], place : MKPlacemark) -> [ClassModel]{
        //My location
        let location = place.location
        
        //My buddy's location
//        let myBuddysLocation = CLLocation(latitude: 59.326354, longitude: 18.072310)
        
        return array.filter({ model -> Bool in
            let placeLocation = CLLocation(latitude: model.latitude, longitude: model.longtitude)
            //Measuring my distance to my buddy's (in km)
            let distance = location!.distance(from: placeLocation) / 1000
            
            //Display the result in km
            print(String(format: "The distance to my buddy is %.01fkm", distance))
            return distance < 0.6
        })
        
        //Measuring my distance to my buddy's (in km)
//        let distance = myLocation.distance(from: myBuddysLocation) / 1000
        
        //Display the result in km
//        print(String(format: "The distance to my buddy is %.01fkm", distance))
//        return array
    }
   
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //        Get the new view controller using segue.destination.
        //        Pass the selected object to the new view controller.
        //        mapview_identifier
        if segue.identifier == "mapview_identifier"
        {
            if let destinationVC = segue.destination as? MapViewController {
                destinationVC.mapDelegate = self
            }
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

extension ActivityListViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let array = filteredArray else {
            add(emptyView)
            return 0
        }
        array.count > 0 ? emptyView.remove() : add(emptyView)
        
        return array.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AcitivityListTableViewCell") as! AcitivityListTableViewCell
        
        
       let model = filteredArray![indexPath.row]
       cell.setupCell(model: model)
       cell.likeButton.tag = indexPath.row
        cell.likeButton.addTarget(self, action: #selector(likeButtonPressed), for: .touchUpInside)

        return cell //4.
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 195
    }
    
    
}

extension ActivityListViewController : MapViewDelegate{
    func mapViewDidSelectedPlace(mapItem: MKPlacemark) {
        self.placeMark = mapItem
        self.locationLabel.text = self.placeMark?.name
        
//        locationText.text = mapItem.name
//        locationSelected.0 = mapItem.name ?? ""
//        locationSelected.1 = mapItem.coordinate.latitude
//        locationSelected.2 = mapItem.coordinate.longitude
        filterList()
    }
}

extension ActivityListViewController{
    static func instance (activitiesType : ButtonType)-> ActivityListViewController {
        
        let view = UIStoryboard.storyboard(.views).instantiateViewController(withIdentifier:ActivityListViewController.storyboardIdentifier) as! ActivityListViewController
        view.activityType = activitiesType
        
        return view
    }
}
