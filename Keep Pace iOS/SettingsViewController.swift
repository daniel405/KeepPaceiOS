//
//  SettingsViewController.swift
//  Keep Pace iOS
//
//  Created by Daniel Katz on 2018-04-25.
//  Copyright © 2018 Daniel Katz. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
   
    
    let unitType = UserDefaults.standard.string(forKey: "unitType")
    let modeType = UserDefaults.standard.string(forKey: "modeType")
    
    @IBOutlet var unitButtons: [UIButton]!
    @IBOutlet var modeButtons: [UIButton]!
    
    @IBOutlet weak var unitSelection: UIButton!
    @IBOutlet weak var modeSelection: UIButton!
    
    @IBAction func handleUnitSelection(_ sender: Any) {
        unitButtons.forEach { (button) in
            UIView.animate(withDuration: 0.3, animations: {
                button.isHidden = !button.isHidden
            })
        }
    }
    
    @IBAction func handleModeSelection(_ sender: Any) {
        modeButtons.forEach { (button) in
            UIView.animate(withDuration: 0.3, animations: {
                button.isHidden = !button.isHidden
            })
        }
    }
    
    
    @IBAction func modeTapped(_ sender: Any) {
        modeSelection.setTitle((sender as AnyObject).currentTitle, for: .normal)
        modeButtons.forEach { (button) in
            UIView.animate(withDuration: 0.3, animations: {
                button.isHidden = true
            })
            UserDefaults.standard.set(modeSelection.currentTitle, forKey: "modeType")
        }
    }
    
    
    @IBAction func unitTapped(_ sender: Any) {
        unitSelection.setTitle((sender as AnyObject).currentTitle, for: .normal)
        unitButtons.forEach { (button) in
            UIView.animate(withDuration: 0.3, animations: {
                button.isHidden = true
            })
            UserDefaults.standard.set(unitSelection.currentTitle, forKey: "unitType")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if modeType != nil {
            modeSelection.setTitle(modeType, for: .normal)
        }
        if unitType != nil {
            unitSelection.setTitle(unitType, for: .normal)
        }
        
        //Navigation bar title text
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedStringKey.font: UIFont(name: "Racing Sans One", size: 20)!, NSAttributedStringKey.foregroundColor : UIColor.white]
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
