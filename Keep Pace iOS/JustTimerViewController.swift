//
//  JustTimerViewController.swift
//  Keep Pace iOS
//
//  Created by Daniel Katz on 2018-04-25.
//  Copyright © 2018 Daniel Katz. All rights reserved.
//

import UIKit
import CoreData

class JustTimerViewController: UIViewController, UICollectionViewDelegate,
UICollectionViewDataSource {
    
    let unitType = UserDefaults.standard.string(forKey: "unitType")
    let modeType = UserDefaults.standard.string(forKey: "modeType")
    var raceType : String = ""
    var markersNum = 0
    var grouseGrindMarkers = ["1/4", "1/2", "3/4"]
    var stepsMarkers = ["50", "100", "150", "200", "250", "300", "350", "400", "450"]
    
    @IBOutlet weak var pauseButtonStyle: UIButton!
    @IBOutlet weak var resetButtonStyle: UIButton!
    @IBOutlet weak var startButtonStyle: UIButton!
    @IBOutlet weak var saveButtonStyle: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let dbHelper = DatabaseHelper()
        var raceModel = dbHelper.getRaceModel(idToLookFor: 0)
        
        switch (raceType)
        {
        case "GROUSE GRIND":
            raceModel = dbHelper.getRaceModel(idToLookFor: 4)
        case "437 STEPS (LEFT)":
            raceModel = dbHelper.getRaceModel(idToLookFor: 5)
        case "457 STEPS (RIGHT)":
            raceModel = dbHelper.getRaceModel(idToLookFor: 6)
        case "5K":
            raceModel = dbHelper.getRaceModel(idToLookFor: 0)
        case "10K":
            raceModel = dbHelper.getRaceModel(idToLookFor: 1)
        case "1/2 MARATHON":
            raceModel = dbHelper.getRaceModel(idToLookFor: 2)
        case "FULL MARATHON":
            raceModel = dbHelper.getRaceModel(idToLookFor: 3)
        default:
            raceModel = dbHelper.getRaceModel(idToLookFor: 0)
        }
        
        
        if raceModel != nil {
            if unitType == "M"
            {
                markersNum = Int(ceil(Double((raceModel?.getAsInt(variableToGet: "mMarkers"))!) / 1.6))
                return markersNum
            }
            else
            {
                markersNum = (raceModel?.getAsInt(variableToGet: "mMarkers"))! + 1
                return markersNum
            }
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ButtonCollectionViewCell", for: indexPath) as! ButtonCollectionViewCell
        
        //Round cells
        cell.layer.cornerRadius = cell.frame.size.width / 2
        
        //Set cell labels
        switch (raceType)
        {
        case "GROUSE GRIND":
            if indexPath.row < grouseGrindMarkers.count
            {
                cell.distanceButton.text = grouseGrindMarkers[indexPath.row]
            }
        case "437 STEPS (LEFT)":
            print(indexPath.row)
            if indexPath.row < stepsMarkers.count - 1
            {
                cell.distanceButton.text = stepsMarkers[indexPath.row]
            }
        case "457 STEPS (RIGHT)":
            print(indexPath.row)
            
            if indexPath.row < stepsMarkers.count
            {
                cell.distanceButton.text = stepsMarkers[indexPath.row]
            }
        default:
            if unitType == "M"
            {
                if indexPath.row < markersNum
                {
                    cell.distanceButton.text = String(indexPath.row + 1) + "MI"
                }
            }
            else
            {
                cell.distanceButton.text = String(indexPath.row + 1) + "K"
            }
        }
        
        // "FINISH" label
        if indexPath.row == markersNum - 1
        {
            cell.distanceButton.text = "FINISH"
        }
        
        return cell
    }
    
    // On distance marker select function
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        // "FINISH" selected
        if indexPath.row == markersNum - 1
        {
            collectionView.isHidden = true
            saveButtonStyle.isHidden = false
        }
        
        // Scroll to next cell
        if indexPath.row != markersNum - 1
        {
            self.collectionView?.scrollToItem(at:IndexPath(item: indexPath.row + 1, section: 0), at: .centeredHorizontally, animated: true)
        }
    }
    
    //Start timer
    @IBAction func startButton(_ sender: Any) {
        startButtonStyle.isHidden = true
        collectionView.isHidden = false
    }
    
    // Pause timer
    @IBAction func pauseButton(_ sender: Any) {
        if pauseButtonStyle.currentTitle == "PAUSE"
        {
            pauseButtonStyle.setTitle("RESUME", for: .normal)
        }
        else
        {
            pauseButtonStyle.setTitle("PAUSE", for: .normal)
        }
    }
    
    // Reset timer
    @IBAction func resetButton(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        // Hides collectionView and "SAVE" button
        collectionView.isHidden = true
        saveButtonStyle.isHidden = true
        
        // Rounds "START" and "SAVE" buttons
        startButtonStyle.layer.cornerRadius = startButtonStyle.frame.size.width / 2
        saveButtonStyle.layer.cornerRadius = saveButtonStyle.frame.size.width / 2
        
        // Hides "PAUSE" button on Pro Mode
        if modeType == "Pro Mode"
        {
            pauseButtonStyle.isHidden = true
            pauseButtonStyle.isEnabled = false
            resetButtonStyle.center.x = self.view.center.x
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
