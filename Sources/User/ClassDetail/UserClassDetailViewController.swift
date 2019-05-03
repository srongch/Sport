//
//  UserClassDetailViewController.swift
//  User
//
//  Created by Chhem Sronglong on 22/04/2019.
//  Copyright © 2019 100456065. All rights reserved.
//

import UIKit

class UserClassDetailViewController: UIViewController, ClassDetailViewControllerProtocol {

    private var classID : String = ""
    private var authorID : String = ""
    private var mainVc : ClassDetailViewController?
    @IBOutlet weak var dateButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainVc = ClassDetailViewController.instance(classId: classID, authorId: authorID)
        mainVc!.delegate = self
        if let mc = mainVc {
            add(mc)
        }
        view.bringSubviewToFront(self.dateButton)
        // Do any additional setup after loading the view.
    }
    
    func readMoreReviewsPressed() {
        self.navigationController?.present(ReviewViewController.instance(classId: classID), animated: true, completion: nil)
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//         Get the new view controller using segue.destination.
//         Pass the selected object to the new view controller.
        if (segue.identifier == "checkdateidentifier") {
            if let destinationVC = segue.destination as? CalenderViewController {
                destinationVC.classModel = mainVc!.classModel
                destinationVC.classModel?.key = classID
            }
        }
    }
 

}

extension UserClassDetailViewController {
    static func instance (classId : String, authorId : String)-> UserClassDetailViewController {
        let view = UIStoryboard.storyboard(.classes).instantiateViewController(withIdentifier:"UserClassDetailViewController") as! UserClassDetailViewController
        view.classID = classId
        view.authorID = authorId
        return view
    }
}
