//
//  ConfirmBookingViewController.swift
//  User
//
//  Created by 100456065 on 20/03/2019.
//  Copyright © 2019 100456065. All rights reserved.
//

import UIKit
import SDWebImage

class ConfirmBookingViewController: UIViewController, NaviBarProtocol {
    
    var bookingModel : BookingModel?
    
    @IBOutlet weak var naviBar: NaviBar!
    @IBOutlet weak var classImage: UIImageView!
    @IBOutlet weak var classTitle: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var numberofPeopleLeft: UILabel!
    @IBOutlet weak var numberofPeopleRight: UILabel!
    
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    @IBOutlet weak var confirmButton: LoadingButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        guard (self.bookingModel != nil) else {
            presentAlertView(with: "Some wrong with booking!", isOneButton: true, onDone: {
                self.navigationController?.popViewController(animated: true)
            }, onCancel: {})
            return
        }
        
        setupView()
        
//        setupView(d)
  
    }
    
    func setupView(){
        confirmButton.delegate = self
        naviBar.delegate = self
        let model = bookingModel!
        classImage.sd_setImage(with: URL(string: model.classImage), completed: nil)
        classTitle.text = model.className
        dateLabel.text = model.classDate.toDateWithFormate(format: "MM-DD-YYYY")
        timeLabel.text = "\(model.classTime.toDateWithFormate(format: "HH:SS"))  |  \(model.classHour) hour"
        
        numberofPeopleLeft.text = "£\(model.price)* \(model.numberofPeople)"
        numberofPeopleRight.text = "£\(model.price * Double(model.numberofPeople))"
        
        
        totalPriceLabel.text = numberofPeopleRight.text
    }
    
    func buttonBackPressed() {
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


extension ConfirmBookingViewController : LoadingButtonProtocol {
    func loadingButtonDidPressed() {
        self.confirmButton.start()
        guard let model = self.bookingModel else {
            return
        }
//        let vc = LoadingViewController.instance(self.view.frame)
//        add(vc)
        ClassService().doBooking(bookingModel: model) {[weak self] (error) in
          //  self?.confirmButton.stop()
            if (error){
                self?.presentAlertView(with: "Booking Error, please try again.", isOneButton: true, onDone: {}, onCancel: {})
            }else{
                
                self?.presentAlertView(with: "Booking Completed.", isOneButton: true, onDone: {
                    
                    
                    //set local notification to a specific date
                    let notification = Notification(bookingModel: model)
                    AppDelegate.shared.scheduleNotification(notification: notification)
                    
                    self?.navigationController?.pushViewController(BookingViewController.instance(), animated: true)
                }, onCancel: {})
            }
        }
    }
}

