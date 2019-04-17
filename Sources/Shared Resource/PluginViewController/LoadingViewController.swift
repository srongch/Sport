//
//  MainViewController.swift
//  SportSharing
//
//  Created by Chhem Sronglong on 30/03/2019.
//  Copyright © 2019 100456065. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {
    
    let backgroundView = UIView()
    private lazy var activityIndicator = UIActivityIndicatorView(style: .white)
    var superViewFrame : CGRect = .zero
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        backgroundView.backgroundColor = UIColor.gray.withAlphaComponent(0.4)
        backgroundView.layer.cornerRadius = 25
        backgroundView.clipsToBounds = true
        
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.addSubview(activityIndicator)
        self.view.addSubview(backgroundView)
        self.view.backgroundColor = .clear
        self.view.frame.size = backgroundView.frame.size
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
            backgroundView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // We use a 0.5 second delay to not show an activity indicator
        // in case our data loads very quickly.
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
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
