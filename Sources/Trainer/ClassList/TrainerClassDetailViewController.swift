//
//  TrainerClassDetailViewController.swift
//  Trainer
//
//  Created by Chhem Sronglong on 03/05/2019.
//  Copyright © 2019 100456065. All rights reserved.
//

import UIKit

class TrainerClassDetailViewController: UIViewController, ClassDetailViewControllerProtocol {

    private var classID : String = ""
    private var authorID : String = ""
    private var mainVc : ClassDetailViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        mainVc = ClassDetailViewController.instance(classId: classID, authorId: authorID)
        mainVc!.delegate = self as! ClassDetailViewControllerProtocol
        if let mc = mainVc {
            add(mc)
        }
    }
    
    func readMoreReviewsPressed() {
        self.navigationController?.present(ReviewViewController.instance(classId: classID), animated: true, completion: nil)
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

extension TrainerClassDetailViewController {
    static func instance (classId : String, authorId : String)-> TrainerClassDetailViewController {
        let view = TrainerClassDetailViewController.init()
        view.classID = classId
        view.authorID = authorId
        return view
    }
}
