//
//  UserLogViewController.swift
//  Keep Pace iOS
//
//  Created by Daniel Katz on 2018-04-25.
//  Copyright © 2018 Daniel Katz. All rights reserved.
//

import UIKit

class UserLogViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    let unitType = UserDefaults.standard.string(forKey: "unitType")
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recordCell", for: indexPath) as! ReusableRecordCell
        let recordView = cell.recordCell as! RecordViewTemplate
        let dbHelper = DatabaseHelper()
        let raceModel = dbHelper.getRaceModel(idToLookFor: indexPath.row)
        if raceModel != nil {
            populateCells(recordView: recordView, raceModel: raceModel!)
        }
        return cell
    }
    
    func populateCells(recordView: RecordViewTemplate, raceModel: RaceModel) {
        recordView.nameLabel.text = raceModel.mName
        if unitType == "M" {
            recordView.paceLabel.text = (raceModel.mAveragePace.description) + " mi/h"
        } else {
            recordView.paceLabel.text = (raceModel.mAveragePace.description) + " km/h"
        }
        
        let recordModel = raceModel.getBestRecord()
        
        if recordModel != nil {
            recordView.bestLabel.text = raceModel.timeTextFormat(ms: (recordModel?.mTime)!)
        } else {
            recordView.bestLabel.text = "--:--:--"
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    var selectedOption = -1
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedOption = indexPath.row
        self.performSegue(withIdentifier: "UserLogDetails", sender: indexPath)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "UserLogDetails") {
            let viewController: RecordsViewController = segue.destination as! RecordsViewController
            viewController.curId = selectedOption
        }
    }
    
    @IBOutlet weak var headerView: RecordViewTemplate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        //Navigation bar title text
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedStringKey.font: UIFont(name: "Racing Sans One", size: 20)!, NSAttributedStringKey.foregroundColor : UIColor.white]
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        
        //sets name of header
        headerView.nameLabel.text = "Name"
        headerView.nameLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        
        headerView.paceLabel.text = "Avg. Pace"
        headerView.paceLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        
        headerView.bestLabel.text = "Best Time"
        headerView.bestLabel.font = UIFont.boldSystemFont(ofSize: 16.0)

        tableView.tableFooterView = UIView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
