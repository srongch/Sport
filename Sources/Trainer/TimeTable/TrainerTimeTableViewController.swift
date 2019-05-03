//
//  TrainerTimeTableViewController.swift
//  Trainer
//
//  Created by Chhem Sronglong on 29/04/2019.
//  Copyright © 2019 100456065. All rights reserved.
//

import UIKit

class TrainerTimeTableViewController: UIViewController {

    let vc = TimetableViewController.instance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.view.backgroundColor = .background_color

        // Do any additional setup after loading the view.
    }
    
    func setupView(){
        add(vc)
        
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
