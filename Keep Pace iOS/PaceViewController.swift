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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Navigation bar title text
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedStringKey.font: UIFont(name: "Racing Sans One", size: 20)!, NSAttributedStringKey.foregroundColor : UIColor.white]
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        
        switch (justWildcardText)
        {
        case "Just Grind":
            self.title = "Grind Pace"
        case "Just Crunch":
            self.title = "Crunch Pace"
        case "Just Race":
            self.title = "Race Pace"
        default:
            print ("default")
        }
        
        // Setting wildcard button to "Just Crunch", "Just Grind" or "Just Race"
        justWildcard.setTitle(justWildcardText, for: .normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toJustTimer")
        {
            let DestinationViewController : JustTimerViewController = segue.destination as! JustTimerViewController
            DestinationViewController.titleText = justWildcardText
        }
        else
        {
            let DestinationViewController : BestTimerViewController = segue.destination as! BestTimerViewController
            DestinationViewController.titleText = justWildcardText
        }
    }
}
