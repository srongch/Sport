//
//  MainViewController.swift
//  SportSharing
//
//  Created by Chhem Sronglong on 30/03/2019.
//  Copyright © 2019 100456065. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {
    
    private lazy var activityIndicator = UIActivityIndicatorView(style: .gray)
    var superViewFrame : CGRect = .zero
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        self.view.backgroundColor = .clear
        self.view.frame.size = CGSize(width: 50, height: 50)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // We use a 0.5 second delay to not show an activity indicator
        // in case our data loads very quickly.
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.activityIndicator.startAnimating()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        calculatePreferredSize()
        print("view frame :\(self.view.frame)")
        self.view.center = CGPoint(x: superViewFrame.size.width  / 2,
                                   y: superViewFrame.size.height / 2)
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

extension LoadingViewController {
    static func instance(_ superViewFrame : CGRect) -> LoadingViewController {
        let vc = LoadingViewController()
        vc.superViewFrame = superViewFrame
    return vc
    }
}
