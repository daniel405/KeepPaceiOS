//
//  RecordsViewController.swift
//  Keep Pace iOS
//
//  Created by Daniel Katz on 2018-04-26.
//  Copyright © 2018 Daniel Katz. All rights reserved.
//

import UIKit

class RecordsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let raceModel = dbHelper.getRaceModel(idToLookFor: curId)
        if raceModel != nil {
            return (raceModel?.recordmodel?.count)!
        }
        return 0
    }
    let unitType = UserDefaults.standard.string(forKey: "unitType")
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recordCell", for: indexPath) as! ReusableRecordCell
        let recordView = cell.recordCell as! RecordViewTemplate

        let dbHelper = DatabaseHelper()
        
        let raceModel = dbHelper.getRaceModel(idToLookFor: curId)
        if raceModel != nil {
            if arr.count > 0 {
                populateCells(recordView: recordView, raceModel: raceModel!, recordModel: arr[indexPath.row])
            }
        }
        return cell
    }
    
    //populates cell with details
    func populateCells(recordView: RecordViewTemplate, raceModel: RaceModel, recordModel: RecordModel) {
        recordView.nameLabel.text = recordModel.mDate
        if unitType == "M" {
            recordView.paceLabel.text = String(format: "%.2f", raceModel.convertToMiles(kilometer: recordModel.mAveragePace)) + " mi/h"
        } else {
            recordView.paceLabel.text = String(format: "%.2f", recordModel.mAveragePace) + " km/h"
        }
        recordView.bestLabel.text = recordModel.timeTextFormat(pace: Double(recordModel.mTime))
        //recordView.bestLabel.text = recordModel.mTime.description
    }
    
    @IBOutlet weak var headerView: RecordViewTemplate!
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func deleteButton(_ sender: Any) {
        animateIn()
    }
    @IBAction func clearButton(_ sender: Any) {
        deleteAllRecords()
        tableView.reloadData()
        animateOut()
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        animateOut()
    }
    
    //save id for data display
    var arr: [RecordModel] = []
    var curId: Int = -1
    let dbHelper = DatabaseHelper()
    var effect:UIVisualEffect!
    @IBOutlet var addItemView: UIView!
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Navigation bar title text
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedStringKey.font: UIFont(name: "Racing Sans One", size: 20)!, NSAttributedStringKey.foregroundColor : UIColor.white]
        
        headerView.nameLabel.text = "Date"
        headerView.nameLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        headerView.paceLabel.text = "Avg. Pace"
        headerView.paceLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        headerView.bestLabel.text = "Time"
        headerView.bestLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        tableView.delegate = self
        tableView.dataSource = self
        
        effect = visualEffectView.effect
        visualEffectView.isHidden = true
        addItemView.layer.cornerRadius = 5
        
        tableView.tableFooterView = UIView()

        //let dbHelper = DatabaseHelper()
        
        //Print Objects
//        let raceModel = dbHelper.getRaceModel(idToLookFor: curId)
//            if raceModel != nil {
//                 var arr = raceModel?.recordmodel?.allObjects as! [RecordModel]
//                for item in arr {
//                    dbHelper.printRecordModel(recordModel: item)
//            }
//        }
        
    }
    
    func loadData() {
        let dbHelper = DatabaseHelper()
        
        let raceModel = dbHelper.getRaceModel(idToLookFor: curId)
        
        if raceModel != nil {
            arr = raceModel?.recordmodel?.allObjects as! [RecordModel]
            arr.sort(by: {$0.mTime < $1.mTime})
            print(raceModel?.mName!)
            print(arr)
        }
    }
    
    
    
    func deleteAllRecords() {
        let dbHelper = DatabaseHelper()
        
        let raceModel = dbHelper.getRaceModel(idToLookFor: curId)
        
        if raceModel != nil {
            for item in (raceModel?.recordmodel)! {
                let record = item as! RecordModel
                raceModel?.removeFromRecordmodel(record)
                dbHelper.save()
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
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
            self.visualEffectView.isHidden = true
        }
    }
}
