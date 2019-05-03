//
//  ClassListViewController.swift
//  Trainer
//
//  Created by Chhem Sronglong on 19/04/2019.
//  Copyright © 2019 100456065. All rights reserved.
//

import UIKit

class ClassListViewController: UIViewController {

    
    @IBOutlet weak var noDataLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var modelList = [ClassModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupView()
        self.loadData()
    }
    
    func setupView(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
        let nib = UINib(nibName: "ClassList", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "AcitivityListTableViewCell")
    }
    
    func loadData(){
        
        let vc = LoadingViewController.instance(self.view.frame)
        add(vc)
        
        ClassService().getTrainerClass(authorId: UserService.shared.globalUser!.uid) { (models) in
            vc.remove()
            guard let temp = models else {
                self.noDataLabel.isHidden = false
                return
            }
            self.noDataLabel.isHidden = true
            self.modelList = temp
            self.tableView.reloadData()
            
        }
    }
    
    @IBAction func addClassPressed(_ sender: Any) {
        
        guard (UserService.shared.globalUser?.memo != "") else {
            self.presentAlertView(with: "Please complete your profile first. Procced to profile page?", isOneButton: false, onDone: {
                self.navigationController?.pushViewController(TrainerEditViewController.init(), animated: true)
            }, onCancel: {})
            return
        }
        
        
        let navi = AddClassViewController.instance()
        let vc = navi.visibleViewController as! AddClassViewController
        vc.delegate = self as AddClassViewProtocol
        
        self.navigationController?.present(navi, animated: true, completion: nil)
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

extension ClassListViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return modelList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AcitivityListTableViewCell") as! AcitivityListTableViewCell
     //   cell.backgroundColor = .green
        
        let model = self.modelList[indexPath.row]
        cell.setupCell(model: model)
        cell.likeButton.isHidden = true
        cell.likeButton.tag = indexPath.row
   //     cell.likeButton.addTarget(self, action: #selector(likeButtonPressed), for: .touchUpInside)
        
        return cell //4.
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 195
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.modelList[indexPath.row]
        self.navigationController?.pushViewController(ClassDetailViewController.instance(classId: model.key, authorId: model.authorId), animated: true)
    }
    
}

extension ClassListViewController : AddClassNaviProtocol,AddClassViewProtocol{
    func addClassDidSucess() {
        loadData()
    }
    
    func closeButtonDidPressed() {
    
    }
    
}

extension ClassListViewController  {
    static func instance ()-> UINavigationController {
        return UIStoryboard.storyboard(.classes).instantiateViewController(withIdentifier:"ClassListViewNavi") as! UINavigationController
    }
}
