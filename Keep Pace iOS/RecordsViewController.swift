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
             var arr = raceModel?.recordmodel?.allObjects as! [RecordModel]
//            for item in arr {
//                dbHelper.printRecordModel(recordModel: item)
//            }
//            arr.sort(by: {$0.mTime < $1.mTime})
            populateCells(recordView: recordView, raceModel: raceModel!, recordModel: arr[indexPath.row])
        
        }
        return cell
    }
    
    //populates cell with details
    func populateCells(recordView: RecordViewTemplate, raceModel: RaceModel, recordModel: RecordModel) {
        recordView.nameLabel.text = recordModel.mDate
        if unitType == "M" {
            recordView.paceLabel.text = (recordModel.mAveragePace.description) + " mi/h"
        } else {
            recordView.paceLabel.text = (recordModel.mAveragePace.description) + " km/h"
        }
        recordView.bestLabel.text = raceModel.timeTextFormat(ms: recordModel.mTime)
        //recordView.bestLabel.text = recordModel.mTime.description
    }
    
    @IBOutlet weak var headerView: RecordViewTemplate!
    @IBOutlet weak var tableView: UITableView!
    
    //save id for data display
    var curId: Int = -1
    let dbHelper = DatabaseHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Navigation bar title text
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedStringKey.font: UIFont(name: "Racing Sans One", size: 20)!, NSAttributedStringKey.foregroundColor : UIColor.white]
        
        headerView.nameLabel.text = "Date"
        headerView.paceLabel.text = "Avg. Pace"
        headerView.bestLabel.text = "Time"
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        tableView.delegate = self
        tableView.dataSource = self
        
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
