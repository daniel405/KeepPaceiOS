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
    var markersNum = 0
    var currentMarker = 0

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let dbHelper = DatabaseHelper()
        var raceModel = dbHelper.getRaceModel(idToLookFor: 0)
        
        switch (raceType)
        {
        case "GROUSE GRIND":
            raceModel = dbHelper.getRaceModel(idToLookFor: 4)
        case "437 STEPS (LEFT)":
            raceModel = dbHelper.getRaceModel(idToLookFor: 6)
        case "457 STEPS (RIGHT)":
            raceModel = dbHelper.getRaceModel(idToLookFor: 5)
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
        
        markersNum = (raceModel?.getAsInt(variableToGet: "mMarkers"))! + 1
        
        if raceModel != nil {
            return (raceModel?.getAsInt(variableToGet: "mMarkers"))! + 1
        }
        return 0
    }
    
    var started = false
    var finished = false
    
    @IBOutlet weak var collectionView: UICollectionView!

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ButtonCollectionViewCell", for: indexPath) as! ButtonCollectionViewCell
        
        //Round buttons
        cell.distanceButton.layer.cornerRadius = cell.distanceButton.frame.size.width / 2
        
        cell.distanceButton.tag = indexPath.row
        cell.distanceButton.addTarget(self, action: #selector(BestTimerViewController.btnTapped), for: .touchUpInside)
        

        switch (indexPath.row)
        {
        case 0:
            cell.distanceButton.setTitle("START", for: .normal)
            cell.center.x = self.view.center.x
        case markersNum - 1:
            cell.distanceButton.setTitle("SAVE", for: .normal)
            //cell.isHidden = true

        case markersNum - 2:
            cell.distanceButton.setTitle("FINISH", for: .normal)
            //cell.isHidden = true
        default:
            cell.distanceButton.setTitle(String(indexPath.row) + "K", for: .normal)
           // cell.isHidden = true
        }
        
        cell.isHidden = false
        if started == true && cell.distanceButton.currentTitle! == "START"
        {
            cell.isHidden = true
        }
//        if finished == true && cell.distanceButton.currentTitle! != "SAVE"
//        {
//            cell.isHidden = true
//        }

        return cell
    }
    
    @objc func btnTapped(_ sender : UIButton) {
        let cell = collectionView.cellForItem(at: IndexPath(item: sender.tag, section: 0))
        let distanceButton = sender
        if distanceButton.currentTitle! == "START"
        {
            started = true
            cell?.isHidden = true
        }
        
        if distanceButton.currentTitle! == "FINISH"
        {   
            finished = true
            cell?.isHidden = true
            self.collectionView.scrollToItem(at:IndexPath(item: markersNum - 1, section: 0), at: .centeredHorizontally, animated: false)
        }
        collectionView.reloadData()
    }

    @IBAction func distanceMarkerButton(_ sender: Any) {

    }


    let modeType = UserDefaults.standard.string(forKey: "modeType")
    
    var raceType : String = ""
    var buttons = [UIButton]()
    
    @IBOutlet weak var pauseButtonStyle: UIButton!
    @IBOutlet weak var resetButtonStyle: UIButton!
    
    @IBAction func pauseButton(_ sender: Any) {
    }
    @IBAction func resetButton(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        self.collectionView.scrollToItem(at:IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: false)
        super.viewDidLoad()
        
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
