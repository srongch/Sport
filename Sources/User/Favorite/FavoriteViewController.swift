//
//  FavoriteViewController.swift
//  User
//
//  Created by Chhem Sronglong on 22/04/2019.
//  Copyright © 2019 100456065. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {

    @IBOutlet weak var navi: AddClassNavi!
    @IBOutlet weak var tableView: UITableView!
    var modelList = [ClassModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.loadData()
        // Do any additional setup after loading the view.
    }
    
    func setupView(){
        self.navi.delegate = self
        self.tableView.delegate = self
        self.tableView.dataSource = self
        let nib = UINib(nibName: "ClassList", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "AcitivityListTableViewCell")
    }
    
    func loadData(){
        
        let vc = LoadingViewController.instance(self.view.frame)
        add(vc)
        
        ClassService().userFavorite(userId: UserService.shared.globalUser!.uid) { models , isError in
            vc.remove()
            guard let temp = models else {
//                            self.noDataLabel.isHidden = false
                let vc = EmptyViewController(caseType: .noDataList)
                self.add(vc)
                            return
            }
            
            self.modelList = temp
            self.tableView.reloadData()
        }
        
    }
    
    @objc func likeButtonPressed(_ sender : UIButton){
        print("button tag is \(sender.tag)")
       
        let tempModel = modelList[sender.tag]
        let indexPath = IndexPath(row: sender.tag, section: 0)
        ClassService().addUserLike(userId: UserService.shared.globalUser?.uid ?? "", classId: tempModel.key) { isError, operation in
            
            if isError {
                self.presentAlertView(with: "Operation Failed.", isOneButton: true, onDone: {}, onCancel: {})
                return
            }
            
            switch operation!{
            case "added":
            break
            default:
                self.modelList.remove(at: indexPath.row)
                self.tableView.reloadData()
                break
            }
            
          //  self.loadLikeList(reloadAtIndex: IndexPath(row: sender.tag, section: 0))
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

extension FavoriteViewController : AddClassNaviProtocol{
    func closeButtonDidPressed() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension FavoriteViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.modelList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AcitivityListTableViewCell") as! AcitivityListTableViewCell
        //   cell.backgroundColor = .green
        
        let model = self.modelList[indexPath.row]
        cell.setupCell(model: model)
        cell.likeButton.tag = indexPath.row
        cell.likeButton.isSelected = true
        cell.likeButton.addTarget(self, action: #selector(likeButtonPressed), for: .touchUpInside)
        
        return cell //4.
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 195
    }
    
}

extension FavoriteViewController {
    static func instance ()-> FavoriteViewController {
        return UIStoryboard.storyboard(.favorite).instantiateViewController(withIdentifier:"FavoriteViewController") as! FavoriteViewController
    }

}
