//
//  TrainerProfileViewController.swift
//  SportSharing
//
//  Created by Chhem Sronglong on 18/04/2019.
//  Copyright © 2019 100456065. All rights reserved.
//

import UIKit

class TrainerProfileViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var settingArray: [Setting] {
        return Setting.getSettingArray(isUser : false, isLogin : UserService.shared.isHaveUser)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupView()
    }
    
    func setupView(){
        tableView.delegate = self
        tableView.dataSource = self
        
        self.tableView.sectionHeaderHeight = UITableView.automaticDimension
        self.tableView.sectionFooterHeight = UITableView.automaticDimension
        self.tableView.estimatedSectionHeaderHeight = 200 //a rough estimate, doesn't need to be
        self.tableView.estimatedSectionFooterHeight = 50 + 20 + 20
        let headerNib = UINib.init(nibName: ProfileHeaderView.className, bundle: Bundle.main)
        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: ProfileHeaderView.className)
        let footerNib = UINib.init(nibName: ProfileFooterView.className, bundle: Bundle.main)
        tableView.register(footerNib, forHeaderFooterViewReuseIdentifier: ProfileFooterView.className)
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


extension TrainerProfileViewController : UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = settingArray[indexPath.row]
        switch row.settingType {
        case .editProfile:
            print("edit profile")
            let vc = TrainerEditViewController.init()
            vc.delegate = self
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            print("")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileViewCell.className, for: indexPath) as! ProfileViewCell
        
        let rowSetting = settingArray[indexPath.row]
        cell.setupCell(setting: rowSetting)
//
//        guard let state = profileState else {
//            return cell
//        }
//        switch rowSetting.settingType {
//        case .favorite:
//            cell.setRightText(text: "\(state.like_count)")
//        case .payment:
//            cell.setRightText(text: "\(state.booking_count)")
//        default: break
//
//        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: ProfileHeaderView.className) as! ProfileHeaderView
        if(UserService.shared.isHaveUser){
            headerView.setupUser(user:UserService.shared.globalUser!)
            headerView.setupForTrainer()
        }else{
            headerView.setupNoLogin()
        }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: ProfileFooterView.className) as! ProfileFooterView
        footerView.setupNoLogin(isLogin: UserService.shared.isHaveUser)
        footerView.button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return footerView
    }
    
    @objc func buttonPressed(){
        if (UserService.shared.isHaveUser){
            print("log out")
            AuthService().signOut{ isComplete in
                if (isComplete) {
                   AppDelegate.shared.gotoView(view: TrainerLoginViewController.init())
                }
            }
        }else{
            self.navigationController?.present(LoginViewController.instance(), animated: true, completion: {
                print("presented")
            })
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50 + 20 + 20
    }
}

extension TrainerProfileViewController : EditProfileProtocol{
    func editProfileBackPressed() {
        //
    }
    
    func editProfileSaveComplete() {
        self.tableView.reloadData()
    }
    
    
}

extension TrainerProfileViewController  {
    static func instance ()-> UINavigationController {
        return UIStoryboard.storyboard(.profile).instantiateViewController(withIdentifier:"ProfileNavigation") as! UINavigationController
    }
}


