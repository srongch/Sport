//
//  ProfileViewController.swift
//  SportShare
//
//  Created by Chhem Sronglong on 04/03/2019.
//  Copyright © 2019 Chhem Sronglong. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var settingArray: [Setting] {
        return Setting.getSettingArray(isUser : true, isLogin : UserService.shared.isHaveUser)
    }
    var profileState : ProfileState?
    
    var text = ""
    var isViewIsFirst = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        isViewIsFirst = true
        
        loadData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if (!isViewIsFirst){
            tableView.reloadData()
            loadData()
        }else{
            isViewIsFirst = false
        }
    }
    
    func loadData(){
        if (UserService.shared.isHaveUser){
            let vc = LoadingViewController.instance(self.view.frame)
            add(vc)
            ClassService().profileState(userId:  UserService.shared.globalUser!.uid) {[weak self] model, isError in
                vc.remove()
                if (isError){
                    //do sth
                    self?.presentAlertView(with: "Some worng", isOneButton: true, onDone: {}, onCancel: {})
                }else{
                    self?.profileState = model
                    self?.tableView.reloadData()
                }
            }
        }
    }
    
    

}

extension ProfileViewController : UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = settingArray[indexPath.row]
        switch row.settingType {
        case .editProfile:
            print("edit profile")
            let vc = UserEditProfileViewController.init()
            vc.delegate = self
            self.navigationController?.pushViewController(vc, animated: true)
        case .favorite : print("favorite")
            self.navigationController?.pushViewController(FavoriteViewController.instance(), animated: true)
        case .payment :
            print("payment")
            self.navigationController?.pushViewController(BookingViewController.instance(), animated: true)
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
        
        guard let state = profileState else {
            return cell
        }
        switch rowSetting.settingType {
        case .favorite:
            cell.setRightText(text: "\(state.like_count)")
        case .payment:
            cell.setRightText(text: "\(state.booking_count)")
        default: break
            
        }
        
        return cell
    }
    
 
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: ProfileHeaderView.className) as! ProfileHeaderView
        if(UserService.shared.isHaveUser){
            headerView.setupUser(user:UserService.shared.globalUser!)
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
                    self.tableView.reloadData()
                    
                }
            }
        }else{
            self.navigationController?.present(UserLoginViewController.init(), animated: true, completion: {
                print("presented")
            })
        }
    }
    
     func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50 + 20 + 20
    }
}

extension ProfileViewController : EditProfileProtocol{
    func editProfileBackPressed() {
        
    }
    
    func editProfileSaveComplete() {
        self.tableView.reloadData()
    }

}


extension ProfileViewController {
    static func instance ()-> UINavigationController {
        return UIStoryboard.storyboard(.profile).instantiateViewController(withIdentifier:"UserProfileNavi") as! UINavigationController
    }
    
    static func instancedView ()-> ProfileViewController {
        return UIStoryboard.storyboard(.profile).instantiateViewController(withIdentifier:"ProfileViewController") as! ProfileViewController
    }
    
}
