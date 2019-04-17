//
//  BookingViewController.swift
//  User
//
//  Created by Chhem Sronglong on 20/03/2019.
//  Copyright © 2019 100456065. All rights reserved.
//

import UIKit

class BookingViewController: UIViewController, NaviBarProtocol{

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var naviView: NaviBar!
    
    private var list : [BookingModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.naviView.delegate = self
        self.collectionView.delegate = self
        self.collectionView.dataSource  = self
        self.collectionView.register(UINib(nibName: BookingCell.className, bundle: nil), forCellWithReuseIdentifier: BookingCell.className)
        self.view.backgroundColor = UIColor.white
       
        // Do any additional setup after loading the view.
        let vc = LoadingViewController.instance(self.view.frame)
        add(vc)
        ClassService().bookingList(userId: UserService.shared.globalUser!.uid) {[weak self] (models, isError) in
            self?.list = models
            self?.collectionView.reloadData()
            vc.remove()
        }
    }
    
    func buttonBackPressed(){
        self.navigationController?.popViewController(animated: true)
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

extension BookingViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.list?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: BookingCell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "BookingCell", for: indexPath) as! BookingCell
        cell.setupCell(model: (list![indexPath.row]))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:self.view.frame.size.width, height:132)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 5, right:0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}


extension BookingViewController {
    static func instance ()-> BookingViewController {
        return UIStoryboard.storyboard(.bookings).instantiateViewController(withIdentifier:"BookingViewController") as! BookingViewController
    }
    
    
    
}
