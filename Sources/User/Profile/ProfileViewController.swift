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

    
    var text = ""
    
    lazy var headerView = { () -> ProfileHeaderView in
        let header = ProfileHeaderView.init()
        return header
    }()
    
    lazy var emptyHeader = { () -> UIView in
        let header = UIView.init(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 30))
        return header
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        guard Auth.auth().currentUser == nil  else {
            tableView.tableHeaderView = emptyHeader
            return
        }
        
//        tableView.tableHeaderView = headerView
        self.tableView.sectionHeaderHeight = UITableView.automaticDimension
        self.tableView.sectionFooterHeight = UITableView.automaticDimension
        self.tableView.estimatedSectionHeaderHeight = 200 //a rough estimate, doesn't need to be
        self.tableView.estimatedSectionFooterHeight = 50 + 20 + 20
        let headerNib = UINib.init(nibName: ProfileHeaderView.className, bundle: Bundle.main)
        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: ProfileHeaderView.className)
        let footerNib = UINib.init(nibName: ProfileFooterView.className, bundle: Bundle.main)
        tableView.register(footerNib, forHeaderFooterViewReuseIdentifier: ProfileFooterView.className)

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//
//        guard let headerView = tableView.tableHeaderView else {
//            return
//        }
//
//        // The table view header is created with the frame size set in
//        // the Storyboard. Calculate the new size and reset the header
//        // view to trigger the layout.
//        // Calculate the minimum height of the header view that allows
//        // the text label to fit its preferred width.
//        let size = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
//
//        if headerView.frame.size.height != size.height {
//            headerView.frame.size.height = size.height
//
//            // Need to set the header view property of the table view
//            // to trigger the new layout. Be careful to only do this
//            // once when the height changes or we get stuck in a layout loop.
//            tableView.tableHeaderView = headerView
//
//            // Now that the table view header is sized correctly have
//            // the table view redo its layout so that the cells are
//            // correcly positioned for the new header size.
//            // This only seems to be necessary on iOS 9.
//            tableView.layoutIfNeeded()
//        }
//    }

}

extension ProfileViewController : UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        text += "dgdfgfdgdfg dfgfdgdf fdgfdg fdg fdg"
        tableView.reloadData()
    }
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileViewCell.className, for: indexPath) as! ProfileViewCell
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: ProfileHeaderView.className) as! ProfileHeaderView
        headerView.memoLabel.text = text
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: ProfileFooterView.className) as! ProfileFooterView
        return footerView
    }
    
     func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50 + 20 + 20
    }
}


extension ProfileViewController {
    static func instance ()-> UINavigationController {
        return UIStoryboard.storyboard(.profile).instantiateViewController(withIdentifier:"ProfileNavigation") as! UINavigationController
    }
}
