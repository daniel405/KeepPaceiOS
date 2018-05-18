//
//  ActivityLogViewController.swift
//  Keep Pace iOS
//
//  Created by Daniel Katz on 2018-04-25.
//  Copyright © 2018 Daniel Katz. All rights reserved.
//

import UIKit

class ActivityLogViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recordCell", for: indexPath) as! ReusableRecordCell
        let recordView = cell.recordCell as! RecordViewTemplate
        let dbHelper = DatabaseHelper()
        let raceModel = dbHelper.getRaceModel(idToLookFor: indexPath.row)
        recordView.nameLabel.text = raceModel?.mName
//        recordView.paceLabel.text = String(raceModel?.mAveragePace)
//
//        let recordModel = raceModel?.getBestRecord()
//        recordView.bestLabel.text = String(recordModel?.mTime)
        
        return cell
    }
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    @IBOutlet weak var headerView: RecordViewTemplate!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        //Navigation bar title text
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedStringKey.font: UIFont(name: "Racing Sans One", size: 20)!, NSAttributedStringKey.foregroundColor : UIColor.white]
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        
        headerView.nameLabel.text = "Name"
        headerView.paceLabel.text = "Avg. Pace"
        headerView.bestLabel.text = "Best Time"
        
        tableView.tableFooterView = UIView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
