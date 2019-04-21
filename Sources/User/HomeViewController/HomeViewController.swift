//
//  HomeViewController.swift
//  SportShare
//
//  Created by Chhem Sronglong on 01/03/2019.
//  Copyright © 2019 Chhem Sronglong. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class HomeViewController: UICollectionViewController {


    // MARK: - Properties
    private let classService = ClassService()
    private var classList : [ClassModel]?
    
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    
    private let reuseIdentifier = "HomeCollectionViewCell"
    private let sectionInsets = UIEdgeInsets(top: 0.0,
                                             left: 15.0,
                                             bottom: 30.0,
                                             right: 15.0)
    
    private let itemsPerRow: CGFloat = 2
    var isViewIsFirst = false

    override func viewDidLoad() {
        super.viewDidLoad()

        let loadingVC = LoadingViewController.instance(self.view.frame)
        add(loadingVC)
        isViewIsFirst = true
        classService.getHomeClass(forLimit: 4) {[weak self] (models) in
            loadingVC.remove()
            guard let temp = models else{
                print("no data")
                return
            }
            print(temp)
            self?.classList = models
            self?.collectionView.reloadData()
        }
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.setupUserInfo()
        collectionView.reloadData()
        
    }
    
    func setupUserInfo() {
        if (isViewIsFirst) {
            collectionView.reloadData()
        }else{
            isViewIsFirst = false
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
}


// MARK: - UICollectionViewDataSource
extension HomeViewController : CategoryButtonPressedProtocol {

    
    //1
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //2
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return classList?.count ?? 0
    }
    
    //3
    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
        ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                      for: indexPath) as! HomeCollectionViewCell
        cell.setupCell(model: classList![indexPath.row])
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 viewForSupplementaryElementOfKind kind: String,
                                 at indexPath: IndexPath) -> UICollectionReusableView {
        // 1
        switch kind {
        // 2
        case UICollectionView.elementKindSectionHeader:
            // 3
            guard
                let headerView = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: "\(HomeCollectionReusableView.self)",
                    for: indexPath) as? HomeCollectionReusableView
                else {
                    fatalError("Invalid view type")
            }
            headerView.setDelegate(deletgate: self)
            print("is have user \(UserService.shared.isHaveUser)")
            if (UserService.shared.isHaveUser){
                headerView.setupHeaderForLogin(user: UserService.shared.globalUser!)
            }else{
                headerView.setupHeaderForNotLogin()
            }
            
            return headerView
            
    
        case UICollectionView.elementKindSectionFooter:
            // 3
            guard
                let footerView = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: "\(HomeCollectionFooter.self)",
                    for: indexPath) as? HomeCollectionFooter
                else {
                    fatalError("Invalid view type")
            }
            
            footerView.showAllButton.addTarget(self, action: #selector(showAllButtonPressed), for: .touchUpInside)
            
            //            let searchTerm = searches[indexPath.section].searchTerm
            //            headerView.label.text = searchTerm
            return footerView
            
            
        default:
            // 4
            assert(false, "Invalid element type")
        }
    }
    
    @objc func showAllButtonPressed(_ sender : UIButton){
        print("show all pressed")
    self.navigationController?.pushViewController(ActivityListViewController.instance(activitiesType:.topRated), animated:true)
    }
    
    func buttonDidPressed(buttonType: ButtonType) {
        print("Button Press \(buttonType.getTuple.name)")
        self.navigationController?.pushViewController(ActivityListViewController.instance(activitiesType: buttonType), animated:true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = classList![indexPath.row]
        self.navigationController?.pushViewController(ClassDetailViewController.instance(classId: model.key,authorId: model.authorId), animated: true)
    }
    
}

// MARK: - Collection View Flow Layout Delegate
extension HomeViewController : UICollectionViewDelegateFlowLayout {
    //1
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        //2
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: 171)
    }
    
    //3
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    // 4
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize{
        return CGSize(width: self.view.bounds.width, height: 348)
    }
}

extension HomeViewController {
    static func instance ()-> UINavigationController {
        
        return UIStoryboard.storyboard(.views).instantiateViewController(withIdentifier:"HomeNavigation") as! UINavigationController
    }
}
