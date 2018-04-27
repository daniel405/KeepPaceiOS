//
//  TOSViewController.swift
//  Keep Pace iOS
//
//  Created by Daniel Katz on 2018-04-25.
//  Copyright © 2018 Daniel Katz. All rights reserved.
//

import UIKit

class TOSViewController: UIViewController {

    @IBOutlet weak var tosLinkLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer(target: self, action: #selector(TOSViewController.tapFunction))
        tosLinkLabel.isUserInteractionEnabled = true
        tosLinkLabel.addGestureRecognizer(tap)
    }
    @objc func tapFunction(sender:UITapGestureRecognizer) {
        UIApplication.shared.open(URL(string : "http://www.google.com")!, options: [:], completionHandler: { (status) in
        })
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
