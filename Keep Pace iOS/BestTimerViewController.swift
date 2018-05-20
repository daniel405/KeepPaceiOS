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
    var timer = Timer()
    var counter = 0.0
    let unitType = UserDefaults.standard.string(forKey: "unitType")
    let modeType = UserDefaults.standard.string(forKey: "modeType")
    var raceType : String = ""
    var markersNum = 0
    var currentPace = 0.0
    var saved = false
    var estimatedFinishTime = 0.0
    var pace = 0.0
    var dbHelper = DatabaseHelper()
    var raceModel = RaceModel()
    var recordModel = RecordModel()
    var started = false
    var grouseGrindMarkers = ["1/4", "1/2", "3/4"]
    var stepsMarkers = ["50", "100", "150", "200", "250", "300", "350", "400", "450"]
    var effect:UIVisualEffect!
    let date = Date()
    let formatter = DateFormatter()
    
    @IBOutlet weak var pauseButtonStyle: UIButton!
    @IBOutlet weak var resetButtonStyle: UIButton!
    @IBOutlet weak var startButtonStyle: UIButton!
    @IBOutlet weak var saveButtonStyle: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var bestRecordLabel: UILabel!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var estimatedTimeLabel: UILabel!
    @IBOutlet weak var currentPaceLabel: UILabel!
    @IBOutlet var addItemView: UIView!
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            if unitType == "M" && (raceType == "1/2 MARATHON" || raceType == "FULL MARATHON")
            {
                    markersNum = Int(ceil(Double((raceModel.getAsInt(variableToGet: "mMarkers"))) / 1.609344497892563))
            }
            else
            {
                markersNum = (raceModel.getAsInt(variableToGet: "mMarkers")) + 1
            }
        return markersNum
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ButtonCollectionViewCell", for: indexPath) as! ButtonCollectionViewCell
        
        //Round buttons
        cell.layer.cornerRadius = cell.frame.size.width / 2
       
        switch (raceType)
        {
        case "GROUSE GRIND":
            if indexPath.row < grouseGrindMarkers.count
            {
                cell.distanceButton.text = grouseGrindMarkers[indexPath.row]
            }
        case "437 STEPS (LEFT)":
            if indexPath.row < stepsMarkers.count - 1
            {
                cell.distanceButton.text = stepsMarkers[indexPath.row]
            }
        case "457 STEPS (RIGHT)":
            if indexPath.row < stepsMarkers.count
            {
                cell.distanceButton.text = stepsMarkers[indexPath.row]
            }
        default:
            if unitType == "M" && (raceType == "1/2 MARATHON" || raceType == "FULL MARATHON")
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
        
        if indexPath.row == markersNum - 1
        {
            cell.distanceButton.text = "FINISH"
        }

        return cell
    }
    
    // On distance marker select function
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //Finish tapped
        if indexPath.row == markersNum - 1
        {
            timer.invalidate()
            estimatedTimeLabel.text = currentTimeLabel.text
            collectionView.isHidden = true
            saveButtonStyle.isHidden = false
            pauseButtonStyle.isHidden = true
            resetButtonStyle.isHidden = true
        }
        
        // Scroll to next marker button on tap
        if indexPath.row != markersNum - 1
        {
            self.collectionView?.scrollToItem(at:IndexPath(item: indexPath.row + 1, section: 0), at: .centeredHorizontally, animated: true)
        }
        
        currentPace = getCurrentPace(currentMarker: indexPath.row + 1, currentTime: counter)
        pace = currentPace * 1000.0 * 60.0 * 60.0
        
        if unitType == "M" && (raceType == "1/2 MARATHON" || raceType == "FULL MARATHON")
        {
            currentPaceLabel.text = String(format: "%.2f", pace) + " mi/h"
        }
        else
        {
            currentPaceLabel.text = String(format: "%.2f", pace) + " km/h"
        }
        
        estimatedTimeLabel.text = timeTextFormat(pace: getEstimatedTime(pace: currentPace))
        
    }
    

    func getCurrentPace(currentMarker: Int, currentTime: Double) -> Double {
       let currentDistance = currentMarker
       return Double(currentDistance) / currentTime
    }
    
    func getEstimatedTime(pace: Double) -> Double {
        if unitType == "M"
        {
            if raceType == "HALF MARATHON"
            {
                estimatedFinishTime = 13.1 / pace
            }
            else if raceType == "FULL MARATHON"
            {
                estimatedFinishTime = 26.2 / pace
            }
        }
        else
        {
            estimatedFinishTime = raceModel.mDistance / pace
        }
        return estimatedFinishTime
    }
    
    // Start timer
    @IBAction func startButton(_ sender: Any) {
        startTimer()
        started = true
        startButtonStyle.isHidden = true
        collectionView.isHidden = false
        if modeType != "Pro Mode"
        {
            pauseButtonStyle.isHidden = false
        }
        pauseButtonStyle.isEnabled = true
        resetButtonStyle.isHidden = false
    }
    
    
    
    @objc func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(UpdateTimer), userInfo: nil, repeats: true)
        RunLoop.main.add(timer, forMode: RunLoopMode.commonModes)
    }

    @objc func UpdateTimer() {
        counter += 1
        currentTimeLabel.text = timeTextFormat(pace: counter)
    }
    
    func timeTextFormat(pace: Double) -> String {
        let msec = Int64(pace / 10) % 100
        var sec = Int64(pace / 1000)
        var min = sec / 60
        let hour = min / 60
        sec = sec % 60
        min = min % 60
        
        if (hour > 0) {
            return String(format: "%02d:%02d:%02d", hour, min, sec)
        }
        return String(format: "%02d:%02d:%02d", min, sec, msec)
    }
    
    // Pause timer
    @IBAction func pauseButton(_ sender: Any) {
        if pauseButtonStyle.currentTitle == "PAUSE"
        {
            timer.invalidate()
            pauseButtonStyle.setTitle("RESUME", for: .normal)
        }
        else
        {
            if started == true
            {
                timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(UpdateTimer), userInfo: nil, repeats: true)
                pauseButtonStyle.setTitle("PAUSE", for: .normal)
            }
        }
    }
    
    // Reset timer
    @IBAction func resetButton(_ sender: Any) {
        timer.invalidate()
        counter = 0
        currentTimeLabel.text = "00:00:00"
        estimatedTimeLabel.text = "00:00:00"
        if unitType == "M"
        {
            currentPaceLabel.text = "0.0 mi/h"

        }
        else
        {
            currentPaceLabel.text = "0.0 km/h"
        }
        currentPace = 0.0
        estimatedFinishTime = 0.0
        pace = 0.0
        started = false
        startButtonStyle.isHidden = false
        collectionView.isHidden = true
        self.collectionView?.scrollToItem(at:IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: true)
        pauseButtonStyle.setTitle("PAUSE", for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        pauseButtonStyle.isHidden = true
        resetButtonStyle.isHidden = true
        pauseButtonStyle.isEnabled = false
        effect = visualEffectView.effect
        visualEffectView.isHidden = true
        addItemView.layer.cornerRadius = 5
        formatter.dateFormat = "yyyy-MM-dd"
        
        switch (raceType)
        {
        case "GROUSE GRIND":
            raceModel = dbHelper.getRaceModel(idToLookFor: 4)!
        case "437 STEPS (LEFT)":
            raceModel = dbHelper.getRaceModel(idToLookFor: 5)!
        case "457 STEPS (RIGHT)":
            raceModel = dbHelper.getRaceModel(idToLookFor: 6)!
        case "5K":
            raceModel = dbHelper.getRaceModel(idToLookFor: 0)!
        case "10K":
            raceModel = dbHelper.getRaceModel(idToLookFor: 1)!
        case "1/2 MARATHON":
            raceModel = dbHelper.getRaceModel(idToLookFor: 2)!
        case "FULL MARATHON":
            raceModel = dbHelper.getRaceModel(idToLookFor: 3)!
        default:
            raceModel = dbHelper.getRaceModel(idToLookFor: 0)!
        }
        
        //Sets best time label
        let bestTime = raceModel.getBestRecord()
        if bestTime != nil {
            bestRecordLabel.text = String(timeTextFormat(pace: Double((bestTime?.mTime)!)))
        }
        
        if raceType == "GROUSE GRIND"
        {
            let image = UIImage(named: "grindstartblue") as UIImage?
            startButtonStyle.setBackgroundImage(image, for: .normal)
        }
        else if raceType == "437 STEPS (LEFT)"
        {
            let image = UIImage(named: "start437blue") as UIImage?
            startButtonStyle.setBackgroundImage(image, for: .normal)
        }
        else if raceType == "457 STEPS (RIGHT)"
        {
            let image = UIImage(named: "start457blue") as UIImage?
            startButtonStyle.setBackgroundImage(image, for: .normal)
        } else {
            startButtonStyle.setTitle("START", for: .normal)
        }
        
        
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
    
    
    @IBAction func save(_ sender: Any) {
        animateIn()
    }
    
    @IBAction func finalSaveButton(_ sender: Any) {
        saveButtonStyle.isEnabled = false
        if saved == false
        {
            saved = true
            let result = formatter.string(from: date)
            let record = dbHelper.createRecord(averagePace: pace, time: Int64(counter), date: result)
            if record != nil {
                raceModel.removeAndAdd(recordModelToAdd: record!)
                dbHelper.save()
            }
        }
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func finalCancelButton(_ sender: Any) {
        animateOut()
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func animateIn() {
        self.view.addSubview(addItemView)
        addItemView.center = self.view.center
        
        addItemView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        addItemView.alpha = 0
        
        UIView.animate(withDuration: 0.4) {
            self.visualEffectView.isHidden = false
            self.addItemView.alpha = 1
            self.addItemView.transform = CGAffineTransform.identity
        }
    }
    
    func animateOut () {
        UIView.animate(withDuration: 0.3, animations: {
            self.addItemView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.addItemView.alpha = 0
            
            self.visualEffectView.isHidden = true
            
        }) { (success:Bool) in
            self.addItemView.removeFromSuperview()
        }
    }
    
    func paceNotification() {
        
    }
}


