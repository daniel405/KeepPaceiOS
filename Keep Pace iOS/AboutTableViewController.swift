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
   
    // "Contact Us" label
    @IBOutlet weak var contactUsLabel: UIView!
    
    // "Rate This App" label
    @IBOutlet weak var rateThisAppLabel: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Adds gesture to "Rate This App" label
        let rateTap = UITapGestureRecognizer(target: self, action: #selector(AboutTableViewController.rateThisApp))
        contactUsLabel.isUserInteractionEnabled = true
        contactUsLabel.addGestureRecognizer(rateTap)
        
        // Adds gesture to "Contact Us" label
        let contactTap = UITapGestureRecognizer(target: self, action: #selector(AboutTableViewController.contactUs))
        rateThisAppLabel.isUserInteractionEnabled = true
        rateThisAppLabel.addGestureRecognizer(contactTap)
    }
    
    // Function to rate the app on apple store
    @objc func rateThisApp(sender:UITapGestureRecognizer) {
        //        let url = URL(string: "itms-apps:itunes.apple.com/us/app/apple-store/id\(YOURAPPID)?mt=8&action=write-review")!
        //        UIApplication.shared.openURL(url)
    }
    
    // Function to send an email to Keep Pace.
    @objc func contactUs(sender:UITapGestureRecognizer) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self as? MFMailComposeViewControllerDelegate
            //mail.setToRecipients(["stephen@sclfitness.ca"])
            mail.setToRecipients(["daniel_katz@hotmail.ca"])
            mail.setMessageBody("<p>You're so awesome!</p>", isHTML: true)
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
        return 2
    }

}
