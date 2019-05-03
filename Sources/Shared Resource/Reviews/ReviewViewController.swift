//
//  ReviewViewController.swift
//  SportShare
//
//  Created by Chhem Sronglong on 04/03/2019.
//  Copyright © 2019 Chhem Sronglong. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    var classId : String = ""
    var reviewList : [ReviewModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        let nib = UINib(nibName: "ReviewTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ReviewCell")
        tableView.estimatedRowHeight = 85.0
        tableView.rowHeight = UITableView.automaticDimension
        
        let vc = LoadingViewController.instance(view.frame)
        add(vc)
        ReviewServices().getReview(classId: self.classId) { reviewModels in
            self.reviewList = reviewModels
            self.tableView.reloadData()
            vc.remove()
        }
        
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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

extension ReviewViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.reviewList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell") as! ReviewTableViewCell
        if let model = self.reviewList?[indexPath.row] {
            cell.setupCell(model: model)
        }
        return cell
    }
    
    
}

extension ReviewViewController {
//    ReviewViewController
    static func instance (classId : String)-> ReviewViewController {
        
        let vc = UIStoryboard.storyboard(.reviews).instantiateViewController(withIdentifier:"ReviewViewController") as! ReviewViewController
        vc.classId = classId
        return vc
    }
}
