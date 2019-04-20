//
//  NotLoginViewController.swift
//  User
//
//  Created by Chhem Sronglong on 20/04/2019.
//  Copyright © 2019 100456065. All rights reserved.
//

import UIKit

class NotLoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        
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

extension NotLoginViewController{
    static func instance ()-> NotLoginViewController {
        return UIStoryboard.storyboard(.timetable).instantiateViewController(withIdentifier:"NotLoginViewController") as! NotLoginViewController
    }
}
