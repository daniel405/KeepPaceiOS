//
//  CrunchViewController.swift
//  Keep Pace iOS
//
//  Created by Daniel Katz on 2018-04-25.
//  Copyright © 2018 Daniel Katz. All rights reserved.
//

import UIKit

class CrunchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Navigation bar title text
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedStringKey.font: UIFont(name: "Racing Sans One", size: 20)!, NSAttributedStringKey.foregroundColor : UIColor.white]
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // 457 Steps button action
    @IBAction func button_457(_ sender: Any) {
        performSegue(withIdentifier: "fromCrunch", sender: sender)
    }
    
    // 437 Steps button action
    @IBAction func button_437(_ sender: Any) {
        performSegue(withIdentifier: "fromCrunch", sender: sender)
    }
    
    // Sets wildcard button string to "Just Crunch"
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let DestinationViewController : PaceViewController = segue.destination as! PaceViewController
            DestinationViewController.justWildcardText = "Just Crunch"
    }
}
