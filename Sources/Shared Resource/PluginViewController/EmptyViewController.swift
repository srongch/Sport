//
//  EmptyViewController.swift
//  SportSharing
//
//  Created by Chhem Sronglong on 30/03/2019.
//  Copyright © 2019 100456065. All rights reserved.
//

import UIKit

enum EmptyStringType : String {
    case noDataList = "This is now data."
}

class EmptyViewController: UIViewController {
    
    private var emptyLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        emptyLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emptyLabel)
       
        NSLayoutConstraint.activate([
            emptyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])

        // Do any additional setup after loading the view.
    }
    
    init(caseType : EmptyStringType) {
        super.init(nibName: nil, bundle: nil)
        emptyLabel.translatesAutoresizingMaskIntoConstraints = false
        emptyLabel.text = caseType.rawValue
//        emptyLabel.font = viewModel.descriptionFont
        emptyLabel.textColor = UIColor.blueColor
        emptyLabel.numberOfLines = 0
        emptyLabel.textAlignment = .center
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
