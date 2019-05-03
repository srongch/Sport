//
//  MapViewController.swift
//  Trainer
//
//  Created by Chhem Sronglong on 14/03/2019.
//  Copyright © 2019 100456065. All rights reserved.
//

import UIKit
import MapKit

protocol MapViewDelegate {
    func mapViewDidSelectedPlace(mapItem: MKPlacemark)
}

class MapViewController: UIViewController,UISearchBarDelegate {

    @IBOutlet weak var navi: AddClassNavi!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchResultTableView: UITableView!
    var searchResult : [MKMapItem] = []
    var mapDelegate : MapViewDelegate?
    var selectedPin: MKPlacemark?
    let regionRadius: Double = 1000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
//        mapVi
//        mapView.showsUserLocation = true
        mapView.delegate = self
        
        searchBar.delegate = self
        searchResultTableView.delegate = self
        searchResultTableView?.dataSource = self
        searchResultTableView.isHidden = true
        navi.delegate = self
        self.centerMapOnUserLocation()
    }
    
    @IBAction func addLocation(_ sender: Any) {
                guard let mapdeletegate = mapDelegate,
                      let pinSelected = selectedPin else {
                        presentAlertView(with: "Please user search box to select location.", isOneButton: true, onDone: {}, onCancel: {})
                    return
                }
                self.dismiss(animated: true) {
                    mapdeletegate.mapViewDidSelectedPlace(mapItem: pinSelected)
                }
    }
    
    func centerMapOnUserLocation() {
            guard let locationmanager = AppDelegate.shared.getLocationManger(),
            let coordinate = locationmanager.location?.coordinate else {return}
            let coordinateRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
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

extension MapViewController : AddClassNaviProtocol {

    func closeButtonDidPressed(){
        self.dismiss(animated: true, completion: nil)
    }
}

extension MapViewController : MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, didUpdate
        userLocation: MKUserLocation) {
        mapView.centerCoordinate = userLocation.location!.coordinate
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?{
        
        guard !(annotation is MKUserLocation) else { return nil }
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
        }
        pinView?.pinTintColor = UIColor.orange
        pinView?.canShowCallout = true
        let smallSquare = CGSize(width: 18, height: 21)
        let button = UIButton(frame: CGRect(origin: CGPoint.zero, size: smallSquare))
        button.setBackgroundImage(UIImage(named: "location_icon"), for: .normal)
//        button.addTarget(self, action: #selector(ViewController.getDirections), for: .TouchUpInside)
        pinView?.leftCalloutAccessoryView = button
        
        return pinView
    }
    
}


extension MapViewController {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
      
        searchOnMap()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("search")
        searchOnMap()
        self.view.endEditing(true)
      
    }
    
    func searchOnMap () {
        guard let mapView = mapView,
            let searchText = searchBar.text, !searchText.isEmpty  else {
                searchResultTableView.isHidden = true
                return
                
        }
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText
        request.region = mapView.region
        let search = MKLocalSearch(request: request)
        
        search.start { response, _ in
            guard let response = response else {
                return
            }
            
            self.searchResult = response.mapItems
            self.searchResultTableView.reloadData()
            self.searchResultTableView.isHidden = self.searchResult.count <= 0
        }
    }
    
    func parseAddress(selectedItem:MKPlacemark) -> String {
        
        // put a space between "4" and "Melrose Place"
        let firstSpace = (selectedItem.subThoroughfare != nil &&
            selectedItem.thoroughfare != nil) ? " " : ""
        
        // put a comma between street and city/state
        let comma = (selectedItem.subThoroughfare != nil || selectedItem.thoroughfare != nil) &&
            (selectedItem.subAdministrativeArea != nil || selectedItem.administrativeArea != nil) ? ", " : ""
        
        // put a space between "Washington" and "DC"
        let secondSpace = (selectedItem.subAdministrativeArea != nil &&
            selectedItem.administrativeArea != nil) ? " " : ""
        
        let addressLine = String(
            format:"%@%@%@%@%@%@%@",
            // street number
            selectedItem.subThoroughfare ?? "",
            firstSpace,
            // street name
            selectedItem.thoroughfare ?? "",
            comma,
            // city
            selectedItem.locality ?? "",
            secondSpace,
            // state
            selectedItem.administrativeArea ?? ""
        )
        
        return addressLine
    }
}


extension MapViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        let selectedItem = searchResult[indexPath.row].placemark
        cell.textLabel?.text = selectedItem.name
        cell.detailTextLabel?.text = parseAddress(selectedItem: selectedItem)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        searchResultTableView.isHidden = true
        self.view.endEditing(true)
        
        // cache the pin
        selectedPin = self.searchResult[indexPath.row].placemark
        
        guard let pinSelection = selectedPin else {return}
        
        // clear existing pins
        mapView.removeAnnotations(mapView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = pinSelection.coordinate
        annotation.title = pinSelection.name
        
        if let city = pinSelection.locality,
            let state = pinSelection.administrativeArea {
            annotation.subtitle = "\(city) \(state)"
        }
        
        mapView.addAnnotation(annotation)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
         let region = MKCoordinateRegion(center: pinSelection.coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
    

    
}
