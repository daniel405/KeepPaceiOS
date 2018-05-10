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
        
        //Navigation bar title text
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedStringKey.font: UIFont(name: "Racing Sans One", size: 20)!, NSAttributedStringKey.foregroundColor : UIColor.white]
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
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
    
    // 5K button style
    @IBOutlet weak var button_style_5K: UIButton!
    
    // 10K button style
    @IBOutlet weak var button_style_10K: UIButton!
    
    // 1/2 marathon button style
    @IBOutlet weak var button_style_halfMarathon: UIButton!
    
    // Full marathon button style
    @IBOutlet weak var button_style_fullMarathon: UIButton!

    // Sets wildcard button string to "JUST RACE" and sets navigation bar title to title of button tapped
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let DestinationViewController : PaceViewController = segue.destination as! PaceViewController
            DestinationViewController.justWildcardText = "JUST RACE"
        
        if let button_style_5K = sender as? UIButton
        {
            DestinationViewController.titleText = button_style_5K.currentTitle!
        }
        else if let button_style_10K = sender as? UIButton
        {
            DestinationViewController.titleText = button_style_10K.currentTitle!
        }
        else if let button_style_halfMararthon = sender as? UIButton
        {
            DestinationViewController.titleText = button_style_halfMararthon.currentTitle!
        }
        else
        {
            DestinationViewController.titleText = button_style_fullMarathon.currentTitle!
        }
    }
}
