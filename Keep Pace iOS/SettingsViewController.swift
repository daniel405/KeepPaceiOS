//
//  SettingsViewController.swift
//  Keep Pace iOS
//
//  Created by Daniel Katz on 2018-04-25.
//  Copyright © 2018 Daniel Katz. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var modeType: UILabel!
    @IBOutlet weak var modeSwitch: UISwitch!
    
    @IBAction func modeSwitchToggle(_ sender: Any) {
        if modeSwitch.isOn == true
        {
            modeType.text = "On"
        }
        else
        {
            modeType.text = "Off"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Title logo
        let logo = UIImage(named: "KP(Blue)")
        let imageView = UIImageView(image:logo)
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
        
        modeSwitch.isOn = false
        if modeSwitch.isOn == true
        {
            modeType.text = "On"
        }
        else
        {
            modeType.text = "Off"
        }
     
        // Calls function "backToHome"
        let tapBackToHome = UITapGestureRecognizer(target: self, action: #selector(SettingsViewController.backToHome))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapBackToHome)
    }
    
    // Goes back to home page
    @objc func backToHome(sender:UITapGestureRecognizer) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
