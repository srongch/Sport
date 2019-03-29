//
//  ActivityListViewController.swift
//  SportShare
//
//  Created by Chhem Sronglong on 02/03/2019.
//  Copyright © 2019 Chhem Sronglong. All rights reserved.
//

import UIKit

class ActivityListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var naviTitle: UILabel!
    
    @IBOutlet weak var beginner: UIButton!
    @IBOutlet weak var intermediate: UIButton!
    @IBOutlet weak var advance: UIButton!
    @IBOutlet weak var noDataLabel: UILabel!
    
    var buttonArray : [UIButton]?
   
    var activityType : ButtonType = .swimming
    
    let classService = ClassService()
    var classArray : [ClassModel]?
    var filteredArray : [ClassModel]?
    
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
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func levelButtonPressed(_ sender: UIButton) {
        sender.setLevelButtonSelected(buttons: [beginner,intermediate,advance])
    }
    
    @objc func likeButtonPressed(_ sender : UIButton){
        print("button tag is \(sender.tag)")
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
            noDataLabel.isHidden = false
            return 0
        }
        noDataLabel.isHidden = array.count > 0
        
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

extension ActivityListViewController{
    static func instance (activitiesType : ButtonType)-> ActivityListViewController {
        
        let view = UIStoryboard.storyboard(.views).instantiateViewController(withIdentifier:ActivityListViewController.storyboardIdentifier) as! ActivityListViewController
        view.activityType = activitiesType
        
        return view
    }
}
