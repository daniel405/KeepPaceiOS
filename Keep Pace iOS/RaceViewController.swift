//
//  RaceViewController.swift
//  Keep Pace iOS
//
//  Created by Daniel Katz on 2018-04-25.
//  Copyright © 2018 Daniel Katz. All rights reserved.
//

import UIKit

class RaceViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Title logo
        let logo = UIImage(named: "KP(Blue)")
        let imageView = UIImageView(image:logo)
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
        
        
        // Calls function "backToHome"
        let tapBackToHome = UITapGestureRecognizer(target: self, action: #selector(RaceViewController.backToHome))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapBackToHome)
    }
    
    // Opens Terms of Service on website
    @objc func backToHome(sender:UITapGestureRecognizer) {
        self.navigationController?.popToRootViewController(animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // 5 Kilometer button action
    @IBAction func button_5K(_ sender: Any) {
        performSegue(withIdentifier: "fromRace", sender: sender)

    }
    
    // 10 Kilometer button action
    @IBAction func button_10K(_ sender: Any) {
        performSegue(withIdentifier: "fromRace", sender: sender)

    }
    
    // Half marathon button action
    @IBAction func button_halfMarathon(_ sender: Any) {
        performSegue(withIdentifier: "fromRace", sender: sender)

    }
    
    // Full marathon button action
    @IBAction func button_fullfMarathon(_ sender: Any) {
        performSegue(withIdentifier: "fromRace", sender: sender)
    }
    
    
    // Sets wildcard button string to "Just Race"
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let DestinationViewController : PaceViewController = segue.destination as! PaceViewController
            DestinationViewController.justWildcardText = "Just Race"
    }
}
