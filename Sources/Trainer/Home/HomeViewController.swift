//
//  HomeViewController.swift
//  User
//
//  Created by Chhem Sronglong on 09/04/2019.
//  Copyright © 2019 100456065. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var totalDesc: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var bookingList = [Transactions]()
    var totalEarn : Double = 0
    @IBOutlet weak var noDataStackView: UIStackView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.config()
        self.loadData()
    }
    
    func config(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
        let nib = UINib(nibName: "HomeTabCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "HomeTabCell")
        let nibName = UINib(nibName: "HomeTabSectionHeader", bundle: nil)
        self.tableView.register(nibName, forHeaderFooterViewReuseIdentifier: "HomeTabSectionHeader")
        
    }
    
    func updateView(){
        self.tableView.reloadData()
        self.totalLabel.text = "$\(totalEarn)"
    }
    
    func loadData (){
        let vc = LoadingViewController.instance(self.view.frame)
        add(vc)
        
        ClassService().bookingList(authorId: UserService.shared.globalUser?.uid ?? "") { (models, isError) in
            print("size is : \(models?.count)")
            vc.remove()
            guard !isError else{
                self.presentAlertView(with: "Data Load Error! Retry?", isOneButton: false, onDone: {
                    self.loadData()
                }, onCancel: {})
                return
            }
            
            guard let  models = models else{
                // no data.
                self.noDataStackView.isHidden = false
                return
            }
            self.noDataStackView.isHidden = true
            
            models.forEach({ model in
                if let index = self.bookingList.index(where: {$0.isTheSameDate(date: model.timeStamp)}) {
                    var existing = self.bookingList[index]
                    existing.addBooking(bookingModel: model)
                    self.bookingList[index] = existing
                    self.totalEarn += model.price * Double(model.numberofPeople)
                } else {
                    // item could not be found
                    print("no same date")
                    self.bookingList.append(Transactions(bookingModel: model))
                    self.totalEarn += model.price * Double(model.numberofPeople)
                }
            })
            
            self.updateView()
            
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

extension HomeViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return bookingList[section].details.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return bookingList.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = self.tableView.dequeueReusableHeaderFooterView(withIdentifier: "HomeTabSectionHeader" ) as! HomeTabSectionHeader
        headerView.titleLabel?.text = bookingList[section].getDateText()
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTabCell") as! HomeTabCell
        cell.setupCell(bookingModel: self.bookingList[indexPath.section].details[indexPath.row])
        return cell
    }
    
    
}

extension HomeViewController  {
    static func instance ()-> UINavigationController {
        return UIStoryboard.storyboard(.tabbar).instantiateViewController(withIdentifier:"HomeViewControllerNavi") as! UINavigationController
    }
}
