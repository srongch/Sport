//
//  LoadingButton.swift
//  User
//
//  Created by Chhem Sronglong on 05/04/2019.
//  Copyright © 2019 100456065. All rights reserved.
//

import UIKit

protocol LoadingButtonProtocol {
    func loadingButtonDidPressed()
//    fun
}

class LoadingButton: NibView {

    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    private var iconImage : UIImage?
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var wrapper: UIView!
    @IBOutlet weak var wrapperWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var button: UIButton!
    
    var delegate : LoadingButtonProtocol?
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print("init")
        loadingView.isHidden = true
        icon.isHidden = (iconImage == nil) ? true : false
    }
    
    @IBInspectable var title: String = "" {
        didSet {
            self.textLabel.text = title
        }
    }
    
    @IBInspectable var image: UIImage? {
        didSet {
            self.iconImage = image
            self.icon.image = image
        }
    }
    
    
    @IBAction func ButtonPressed(_ sender: UIButton) {
        print("button pressed")
        delegate?.loadingButtonDidPressed()
    }
    
    func start(){
        self.loadingView.showAnimated(in: self.stackView)
        self.loadingView.startAnimating()
    }
    
    func stop(){
        loadingView.hideAnimated(in: self.stackView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        print("view frame \(self.frame)")
        print("stackview frame \(self.stackView.frame)")
        self.wrapperWidthConstraint.constant = self.stackView.frame.size.width + 70
    }

}
