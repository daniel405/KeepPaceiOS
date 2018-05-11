//
//  BestTimerViewController.swift
//  Keep Pace iOS
//
//  Created by Daniel Katz on 2018-04-30.
//  Copyright © 2018 Daniel Katz. All rights reserved.
//

import UIKit
import CoreData

class BestTimerViewController: UIViewController, UICollectionViewDelegate,
UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let dbHelper = DatabaseHelper()
        let raceModel = dbHelper.getRaceModel(idToLookFor: 1)
        if raceModel != nil {
            return (raceModel?.getAsInt(variableToGet: "mMarkers"))!
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ButtonCollectionViewCell", for: indexPath) as! ButtonCollectionViewCell
//
//              cell.distanceButton = UIButton()
//    //        cell.distanceButton = buttonArray[indexPath.row]
//    //        var buttonY: CGFloat = 20
//    //        buttonY = buttonY + 50
//            cell.distanceButton.layer.cornerRadius = 10
//            cell.distanceButton.backgroundColor = UIColor.blue
//    //        cell.distanceButton.setTitle(String(indexPath.row) + "K", for: .normal)
//            print("helloworld")
//            return cell
//
        //let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ButtonCollectionViewCell", for: indexPath) as! ButtonCollectionViewCell
        //cell.isHidden = false
        print("helloworld" + String(indexPath.row))
        return cell
    }
    
    
    let modeType = UserDefaults.standard.string(forKey: "modeType")
    
    var titleText : String = ""
    var buttons = [UIButton]()
    
    @IBOutlet weak var pauseButtonStyle: UIButton!
    @IBOutlet weak var resetButtonStyle: UIButton!
    
    @IBAction func pauseButton(_ sender: Any) {
    }
    @IBAction func resetButton(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if modeType == "Pro Mode"
        {
            pauseButtonStyle.isHidden = true
            pauseButtonStyle.isEnabled = false
            resetButtonStyle.center.x = self.view.center.x
        }
        
        //Navigation bar title text
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedStringKey.font: UIFont(name: "Racing Sans One", size: 20)!, NSAttributedStringKey.foregroundColor : UIColor.white]
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//
//
//
//
    
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ButtonCollectionViewCell", for: indexPath) as! ButtonCollectionViewCell
//
//          cell.distanceButton = UIButton()
////        cell.distanceButton = buttonArray[indexPath.row]
////        var buttonY: CGFloat = 20
////        buttonY = buttonY + 50
//        cell.distanceButton.layer.cornerRadius = 10
//        cell.distanceButton.backgroundColor = UIColor.blue
////        cell.distanceButton.setTitle(String(indexPath.row) + "K", for: .normal)
//        print("helloworld")
//        return cell
//    }
}
