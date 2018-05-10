//
//  TOSViewController.swift
//  Keep Pace iOS
//
//  Created by Daniel Katz on 2018-04-25.
//  Copyright © 2018 Daniel Katz. All rights reserved.
//

import UIKit

class TOSViewController: UIViewController {

    
    @IBOutlet weak var tosLinkLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Calls funciton "tapFunction"
        let tap = UITapGestureRecognizer(target: self, action: #selector(TOSViewController.tapFunction))
        tosLinkLabel.isUserInteractionEnabled = true
        tosLinkLabel.addGestureRecognizer(tap)
    }
    
    // Opens Terms of Service on website
    @objc func tapFunction(sender:UITapGestureRecognizer) {
        UIApplication.shared.open(URL(string : "http://www.google.com")!, options: [:], completionHandler: { (status) in
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
