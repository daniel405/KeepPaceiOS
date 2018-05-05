//
//  ViewController.swift
//  Keep Pace iOS
//
//  Created by Daniel Katz on 2018-04-25.
//  Copyright © 2018 Daniel Katz. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let navBarColor = UIColor(red:45.0/255.0, green:178.0/255.0, blue:252.0/255.0, alpha:1.0)
        navigationController?.navigationBar.barTintColor = navBarColor
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)

        // Title logo
        let logo = UIImage(named: "KP(White)")
        let imageView = UIImageView(image:logo)
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Sets wildcard button string to "Just Grind"
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "fromGrind") {
            let DestinationViewController : PaceViewController = segue.destination as! PaceViewController
            DestinationViewController.justWildcardText = "Just Grind"
        }
    }


}

