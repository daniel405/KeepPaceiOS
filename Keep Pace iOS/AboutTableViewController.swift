//
//  AboutTableViewController.swift
//  Keep Pace iOS
//
//  Created by Daniel Katz on 2018-05-09.
//  Copyright © 2018 Daniel Katz. All rights reserved.
//

import UIKit
import MessageUI

class AboutTableViewController: UITableViewController {
   
    // "About Us" label
    @IBOutlet weak var aboutUsLabel: UILabel!
    
    // "Contact Us" label
    @IBOutlet weak var contactUsLabel: UIView!
    
    // "Rate This App" label
    @IBOutlet weak var rateThisAppLabel: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // Function to send an email to Keep Pace.
    func contactUs() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self as? MFMailComposeViewControllerDelegate
            //mail.setToRecipients(["stephen@sclfitness.ca"])
            mail.setMessageBody("<p>Testing...!</p>", isHTML: true)
            present(mail, animated: true)
        }
    }

    
    
    // Composes email
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch(indexPath.row)
        {
        case 0:
            UIApplication.shared.open(URL(string : "http://www.sclfitness.ca/keep-pace-about")!, options: [:], completionHandler: { (status) in
            })
        case 1:
            UIApplication.shared.open(URL(string : "http://www.sclfitness.ca/keep-pace-contact")!, options: [:], completionHandler: { (status) in
            })
        case 2:
        //        let url = URL(string: "itms-apps:itunes.apple.com/us/app/apple-store/id\(YOURAPPID)?mt=8&action=write-review")!
        //        UIApplication.shared.openURL(url)
            break
        default:
            break
        }
    }
}
