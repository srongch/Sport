//
//  TimetableMenuView.swift
//  User
//
//  Created by Chhem Sronglong on 20/03/2019.
//  Copyright © 2019 100456065. All rights reserved.
//  Adapted from https://github.com/shaoyanglichao01/ScrollMenue

import UIKit

typealias MenuDidSelectItemClosureType = (IndexPath) -> ()

class TimetableMenuView: UICollectionView {
    private let minimumLineAndInteritemSpacingForSection: CGFloat = 10
    private var didSelectItmeClosure: MenuDidSelectItemClosureType!
    private var data : [String]!
    private var selectedIndexPath : IndexPath!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        print("range 1")
         super.init(frame: frame, collectionViewLayout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
         print("range 2")
         super.init(coder: aDecoder)
        self.register(UINib(nibName: "TimetableCell", bundle: nil), forCellWithReuseIdentifier: "TimetableCell")
        self.isScrollEnabled = true
        self.delegate = self
        self.dataSource = self
        self.showsHorizontalScrollIndicator = false
        self.backgroundColor = UIColor.clear
    }
    
    //MARK:- Public Method
    public func setDidSelectItemClosure(closure: @escaping MenuDidSelectItemClosureType) {
        self.didSelectItmeClosure = closure
    }
    
    public func setDataSource (data : [String]){
        self.data = data
        self.reloadData()
    }
    
    
}

extension TimetableMenuView : UICollectionViewDelegate,  UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data?.count ?? 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: TimetableCell = self.dequeueReusableCell(withReuseIdentifier: "TimetableCell", for: indexPath) as! TimetableCell
        
        cell.setupView(isSelected: selectedIndexPath == indexPath)
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if ((selectedIndexPath != nil) && indexPath == selectedIndexPath){
            return
        }
        
        selectedIndexPath = indexPath
        self.reloadData()
        
        self.scrollToItem(at: indexPath, at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
        
        guard let clousor = didSelectItmeClosure else{
            return
        }
        clousor(indexPath)
    }
    
    //MARK:- UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:40, height:self.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumLineAndInteritemSpacingForSection
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minimumLineAndInteritemSpacingForSection
    }
}
