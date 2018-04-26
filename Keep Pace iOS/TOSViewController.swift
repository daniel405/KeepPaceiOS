//
//  TOSViewController.swift
//  Keep Pace iOS
//
//  Created by Daniel Katz on 2018-04-25.
//  Copyright © 2018 Daniel Katz. All rights reserved.
//

import UIKit

class TOSViewController: UIViewController {

    @IBOutlet weak var tosLink: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let attributedString = NSMutableAttributedString(string: "By clicking above, you agree to Keep Pace's Terms & Conditions")
        attributedString.addAttribute(.link, value: "https://www.google.com", range: NSRange(location: 31, length: 31))
        tosLink.attributedText = attributedString
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
