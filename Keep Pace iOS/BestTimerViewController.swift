//
//  BestTimerViewController.swift
//  Keep Pace iOS
//
//  Created by Daniel Katz on 2018-04-30.
//  Copyright © 2018 Daniel Katz. All rights reserved.
//

import UIKit

class BestTimerViewController: UIViewController {

    let modeType = UserDefaults.standard.string(forKey: "modeType")

    var titleText : String = ""
    
    @IBOutlet weak var pauseButtonStyle: UIButton!
    @IBOutlet weak var resetButtonStyle: UIButton!
    
    @IBAction func pauseButton(_ sender: Any) {
    }
    @IBAction func resetButton(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if modeType == "Pro Mode"
        {
            pauseButtonStyle.isHidden = true
            pauseButtonStyle.isEnabled = false
            resetButtonStyle.center.x = self.view.center.x
        }
        
        //Navigation bar title text
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedStringKey.font: UIFont(name: "Racing Sans One", size: 20)!, NSAttributedStringKey.foregroundColor : UIColor.white]
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        
        switch (titleText)
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
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
