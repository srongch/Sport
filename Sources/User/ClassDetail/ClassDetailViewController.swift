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

class ClassDetailViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    var classService = ClassService()
    var classModel = ClassModel()
    
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
    
    @IBOutlet weak var checkDateButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.isPagingEnabled = true
//        scrollView.adjustedContentInset
        scrollView.contentInsetAdjustmentBehavior = .never
        // Do any additional setup after loading the view.
        scrollView.contentInset = .init(top: -45, left: 0, bottom: 0, right: 0)
        
        loadData()
    //     let classesRef = Database.database().reference(withPath: "classes")
    }
    
    func loadData() {

        classService.getClassById(classId: "-LaBKTXLZLJStz33Ipfl") { (model) in
            guard let tempModel = model else {
                //MARK : Data error
                return
            }
            print(tempModel.asDictionary)
            self.classModel = tempModel
            self.setupView()
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
        
        imageView.sd_setImage(with: URL(string:"https://images.unsplash.com/photo-1517070208541-6ddc4d3efbcb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=934&q=80"), completed: nil)
        instructorName.text = "ffghhfghgfh"
        instructorDetail.text = "A highly accomplished and renowned International Trainer and Tedx Speaker has an extensive work experience of 30 years.A highly accomplished and renowned International Trainer and Tedx Speaker has an extensive work experience of 30 years.A highly accomplished and renowned International Trainer and Tedx Speaker has an extensive work experience of 30 years."
        
        programLabel.text = classModel.className
        timeLabel.text = classModel.timeTable
        equipmentLabel.text = classModel.equipment
        
        addressLabel.text = classModel.location
        
        let location = MKPointAnnotation()
        location.title = classModel.location
        location.coordinate = CLLocationCoordinate2D(latitude: classModel.latitude, longitude: classModel.longtitude)
        self.centerMapOnLocation(annotation: location)
    }
    
    func centerMapOnLocation(annotation: MKPointAnnotation) {
        self.mapView.addAnnotation(annotation)
        let coordinateRegion = MKCoordinateRegion(center: annotation.coordinate,
                                                  latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(coordinateRegion, animated: true)
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
    }
}
