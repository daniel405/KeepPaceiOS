//
//  PaceViewController.swift
//  Keep Pace iOS
//
//  Created by Daniel Katz on 2018-04-25.
//  Copyright © 2018 Daniel Katz. All rights reserved.
//

import UIKit

class PaceViewController: UIViewController {

    // Wildcard button
    @IBOutlet weak var justWildcard: UIButton!
    
    // Wildcard button string
    var justWildcardText : String = ""

    //Title Text
    var titleText : String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Navigation bar title text
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedStringKey.font: UIFont(name: "Racing Sans One", size: 20)!, NSAttributedStringKey.foregroundColor : UIColor.white]
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)

        // Sets navigation bar title text string
        switch (titleText)
        {
        case "GROUSE GRIND":
            self.title = "GROUSE GRIND"
        case "437 STEPS (LEFT)":
            self.title = "437 STEPS"
        case "457 STEPS (RIGHT)":
            self.title = "457 STEPS"
        case "5K":
            self.title = "5K"
        case "10K":
            self.title = "10K"
        case "1/2 MARATHON":
            self.title = "1/2 MARATHON"
        case "FULL MARATHON":
            self.title = "FULL MARATHON"
        default:
            print ("default")
        }
        
        // Setting wildcard button title to "JUST STEP", "JUST GRIND" or "JUST RACE"
        justWildcard.setTitle(justWildcardText, for: .normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
