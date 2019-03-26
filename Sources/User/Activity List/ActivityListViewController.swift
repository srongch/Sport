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
    
    var buttonArray : [UIButton]?
   
    var activityType : ButtonType = .swimming
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        naviTitle.text = activityType.getTuple.name
        self.buttonArray = [beginner,intermediate,advance]
        
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func levelButtonPressed(_ sender: UIButton) {
        sender.setLevelButtonSelected(buttons: [beginner,intermediate,advance])
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
        return 5
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AcitivityListTableViewCell") as! AcitivityListTableViewCell
       
        //1.
        
//        let text = data[indexPath.row] //2.
        
//        cell.textLabel?.text = text //3.
        
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
