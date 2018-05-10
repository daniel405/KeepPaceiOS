//
//  SettingsTableViewController.swift
//  Keep Pace iOS
//
//  Created by Daniel Katz on 2018-05-01.
//  Copyright © 2018 Daniel Katz. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    
    
    // Distance unit label (KM / M)
    @IBOutlet weak var distanceUnitLabel: UIButton!

    // "Tell a friend" table cell
    @IBOutlet weak var shareCell: UIView!
    
    // Pro mode switch
    @IBOutlet weak var ProModeSwitch: UISwitch!
    
    // Pro mode switch toggle logic
    @IBAction func ProModeToggle(_ sender: Any) {
        if ProModeSwitch.isOn
        {
            UserDefaults.standard.set("Pro Mode", forKey: "modeType")
        }
        else
        {
           UserDefaults.standard.set("Normal Mode", forKey: "modeType")
        }
        tableView.reloadData()
    }
    
    // Stores unit type key
    let unitType = UserDefaults.standard.string(forKey: "unitType")
    
    // Stores mode type key
    let modeType = UserDefaults.standard.string(forKey: "modeType")

    override func viewDidLoad() {
        super.viewDidLoad()
        self.clearsSelectionOnViewWillAppear = false
        
        // Navigation bar title text
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "Racing Sans One", size: 20)!, NSAttributedStringKey.foregroundColor : UIColor.white]
        
        // Sets unit type text for "distanceUnitLabel"
        if unitType != nil {
            distanceUnitLabel.setTitle(unitType, for: .normal)
        }
        
        // Adds gestures to "Tell a friend" label
        let tap = UITapGestureRecognizer(target: self, action: #selector(SettingsTableViewController.tellAFriend))
        shareCell.isUserInteractionEnabled = true
        shareCell.addGestureRecognizer(tap)
    }
    
    @objc func tellAFriend(sender:UITapGestureRecognizer) {
        let myWebsite = NSURL(string:"https://keeppaceapp.com")
        let shareCell = [myWebsite as Any]
        let activityViewController = UIActivityViewController(activityItems: shareCell, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    // Saves pro mode switch state
    override func viewWillAppear(_ animated: Bool) {
        if modeType == "Pro Mode"
        {
            ProModeSwitch.isOn = true
        }
        else
        {
            ProModeSwitch.isOn = false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    // Unwinds back to SettingsTableViewController
    @IBAction func unwindToVC1(segue:UIStoryboardSegue) { }
}
