//
//  DistanceUnitTableViewController.swift
//  Keep Pace iOS
//
//  Created by Daniel Katz on 2018-05-04.
//  Copyright © 2018 Daniel Katz. All rights reserved.
//

import UIKit

class DistanceUnitTableViewController: UITableViewController {
    
    // "Miles" label
    @IBOutlet weak var mUnit: UITableViewCell!
    
    // "Kilometers label
    @IBOutlet weak var kmUnit: UITableViewCell!

    // Stores unit type key
    let unitType = UserDefaults.standard.string(forKey: "unitType")

    override func viewDidLoad() {
        super.viewDidLoad()
        self.clearsSelectionOnViewWillAppear = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    // Sets unit type key and unwinds to SettingsTableViewController controller after unit selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 // Kilometers tapped
        {
            UserDefaults.standard.set("KM", forKey: "unitType")
        }
        else if indexPath.row == 1 // Miles tapped
        {
            UserDefaults.standard.set("M", forKey: "unitType")
        }
        self.performSegue(withIdentifier: "unwindToVC1", sender: self)
        // navigationController?.popViewController(animated: true)
    }
}
