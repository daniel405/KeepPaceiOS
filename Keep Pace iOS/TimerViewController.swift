//
//  TimerViewController.swift
//  Keep Pace iOS
//
//  Created by Daniel Katz on 2018-04-25.
//  Copyright © 2018 Daniel Katz. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Title logo
        let logo = UIImage(named: "KP(Blue)")
        let imageView = UIImageView(image:logo)
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
        
        // Calls function "backToHome"
        let tapBackToHome = UITapGestureRecognizer(target: self, action: #selector(TimerViewController.backToHome))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapBackToHome)
    }
    
    // Goes back to home page
    @objc func backToHome(sender:UITapGestureRecognizer) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
