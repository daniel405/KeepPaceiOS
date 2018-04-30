//
//  RecordsViewController.swift
//  Keep Pace iOS
//
//  Created by Daniel Katz on 2018-04-26.
//  Copyright © 2018 Daniel Katz. All rights reserved.
//

import UIKit

class RecordsViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Title logo
        let logo = UIImage(named: "KP(Blue)")
        let imageView = UIImageView(image:logo)
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
        
        // Calls function "backToHome"
        let tapBackToHome = UITapGestureRecognizer(target: self, action: #selector(RecordsViewController.backToHome))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapBackToHome)
    }
    
    // Goes back to home page
    @objc func backToHome(sender:UITapGestureRecognizer) {
        self.navigationController?.popToRootViewController(animated: true)
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
