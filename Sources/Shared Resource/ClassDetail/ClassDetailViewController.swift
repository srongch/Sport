//
//  ClassDetailViewController.swift
//  User
//
//  Created by Chhem Sronglong on 18/03/2019.
//  Copyright © 2019 100456065. All rights reserved.
//

import UIKit
import SDWebImage
import Firebase
import MapKit

protocol ClassDetailViewControllerProtocol {
    func readMoreReviewsPressed()
}

class ClassDetailViewController: UIViewController {
    
    var delegate : ClassDetailViewControllerProtocol?
    
    private var classID : String = ""
    private var authorID : String = ""

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var classService = ClassService()
    var classModel = ClassModel()
    var reviewModel = [ReviewModel]()
    
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var classTitle: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var equibment: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var instructorName: UILabel!
    @IBOutlet weak var instructorDetail: UILabel!
    
    @IBOutlet weak var programLabel: UILabel!
    @IBOutlet weak var timetableLabel: UILabel!
    @IBOutlet weak var equipmentLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var reviewTableView: UITableView!
    @IBOutlet weak var reviewTableViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var checkDateButton: UIButton!
    
    @IBOutlet weak var moreButton: UIButton!
    
    
    var previousTableViewYOffset : CGFloat = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.isPagingEnabled = true
//        scrollView.adjustedContentInset
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.contentInset = .init(top: -45, left: 0, bottom: 0, right: 0)
        
        self.scrollView.delegate = self
        
        let nib = UINib(nibName: "ReviewTableViewCell", bundle: nil)
        reviewTableView.register(nib, forCellReuseIdentifier: "ReviewCell")
        reviewTableView.estimatedRowHeight = 85.0
        reviewTableView.rowHeight = UITableView.automaticDimension
        reviewTableView.delegate = self
        reviewTableView.dataSource = self
        
        loadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
     //   reviewTableViewHeightConstraint.constant = self.cellSize
    }
    
    func loadData() {
        let loadingVC = LoadingViewController.instance(self.view.frame,true)
        add(loadingVC)
        classService.classDetailById(classId: classID, authorId : authorID) { (classModel , reviews, isError) in
            loadingVC.remove()
            if(!isError){
               guard let tempModel = classModel else {
                                //MARK : Data error
                                //show error and go back
                                return
                }
                self.classModel = tempModel
                
                guard let review = reviews else{
                    self.setupView()
                    return
                }
                self.reviewModel = review
                self.setupView()
            }else {
                self.presentAlertView(with: "Error", isOneButton : true, onDone: {
                    self.navigationController?.popViewController(animated: true)
                }, onCancel: {})
            }
        }
        
        
        
    }
    
    func setupView(){
        collectionView.reloadData()
        pageControl.numberOfPages = classModel.imageArray.count
        pageControl.currentPage = 0
        
        levelLabel.text = classModel.levelName
        classTitle.text = classModel.className
        locationLabel.text = classModel.location
        equipmentLabel.text = classModel.equipment
        
        priceLabel.text = "£\(classModel.classPrice)"
        
        imageView.sd_setImage(with: URL(string:classModel.getImageFromArray), completed: nil)
        instructorName.text = "Meet your instructor,  \(classModel.authorName)"
        instructorDetail.text = classModel.authorDesc
        
        programLabel.text = classModel.className
        timeLabel.text = classModel.timeTable
        equipmentLabel.text = classModel.equipment
        
        addressLabel.text = classModel.location
        
        let location = MKPointAnnotation()
        location.title = classModel.location
        location.coordinate = CLLocationCoordinate2D(latitude: classModel.latitude, longitude: classModel.longtitude)
        self.centerMapOnLocation(annotation: location)
        reviewTableView.reloadData()
        
        if(reviewModel.count <= 0){
            moreButton.isHidden = true
            self.reviewTableViewHeightConstraint.constant = 20
        }
        
    }
    
    func centerMapOnLocation(annotation: MKPointAnnotation) {
        self.mapView.addAnnotation(annotation)
        let coordinateRegion = MKCoordinateRegion(center: annotation.coordinate,
                                                  latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func moreButtonPressed(_ sender: Any) {
        delegate?.readMoreReviewsPressed()
    }
    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//         Get the new view controller using segue.destination.
//         Pass the selected object to the new view controller.
      
    }
 

}

extension ClassDetailViewController : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return classModel.imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView
            .dequeueReusableCell(withReuseIdentifier: "SlideImageCollectionViewCell",
                                 for: indexPath) as? SlideImageCollectionViewCell
        
        item?.imageView.sd_setImage(with: URL(string: classModel.imageArray[indexPath.row]), completed: nil)
        return item!
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return collectionView.bounds.size
    }
    
    // 6
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
}

extension ClassDetailViewController : UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == collectionView {
            print("collection view scroll")
            let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
            print("page : \(pageIndex)")
            pageControl.currentPage = Int(pageIndex)
        }
        
        if scrollView == scrollView {
            var scrollSpeed = scrollView.contentOffset.y - previousTableViewYOffset
            previousTableViewYOffset = scrollView.contentOffset.y
            print("scroll speed \(scrollSpeed)")
        }
    }
    
}

extension ClassDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell") as! ReviewTableViewCell
        cell.setupCell(model: reviewModel[indexPath.row])
        print("cell size : \(cell.frame.size)")
        if(indexPath.row == reviewModel.count - 1){
            UIView.animate(withDuration: 0, animations: {
//               tableView.layoutIfNeeded()
            }) { complete in
                // Edit heightOfTableViewConstraint's constant to update height of table view
                self.reviewTableViewHeightConstraint.constant = tableView.heightOfVisibleCells() + 40
            }
            
        }
        return cell
    }
    
}


extension ClassDetailViewController {
    static func instance (classId : String, authorId : String)-> ClassDetailViewController {
        let view = UIStoryboard.storyboard(.sharedClasses).instantiateViewController(withIdentifier:"ClassDetailViewController") as! ClassDetailViewController
        view.classID = classId
        view.authorID = authorId
        return view
}
    
    
}
