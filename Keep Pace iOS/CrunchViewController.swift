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
        
        // Title logo
        let logo = UIImage(named: "KP(Blue)")
        let imageView = UIImageView(image:logo)
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
        
        // Calls function "backToHome"
        let tapBackToHome = UITapGestureRecognizer(target: self, action: #selector(CrunchViewController.backToHome))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapBackToHome)
    }
    
    // Goes back to home page
    @objc func backToHome(sender:UITapGestureRecognizer) {
        self.navigationController?.popToRootViewController(animated: true)
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
