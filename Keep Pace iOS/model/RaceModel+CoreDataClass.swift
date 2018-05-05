//
//  RaceModel+CoreDataClass.swift
//  Keep Pace iOS
//
//  Created by Quincy on 2018-04-30.
//  Copyright © 2018 Daniel Katz. All rights reserved.
//
//

import Foundation
import CoreData

//@objc(RaceModel)
public class RaceModel: NSManagedObject {
    //Data Initializer Method for Race Model
    public override func awakeFromInsert() {
        mId = -1
        mName = ""
        mDistance = 0.0
        mMarkers = 0
        mAveragePace = 0.0
        mTime = 0
        mUnit = "km"
    }
    
    //Returns the worst record
    func getWorstRecord() -> RecordModel? {
        if recordmodel?.count == 0 {
            return nil
        }
        var worstRecord = (recordmodel?.allObjects as? [RecordModel])?.first
        for item in recordmodel! {
            let record = item as! RecordModel
            if record.mTime > (worstRecord?.mTime)! {
                worstRecord = record
            }
        }
        return worstRecord
    }
    
    //Returns the best record
    func getBestRecord() -> RecordModel? {
        if recordmodel?.count == 0 {
            return nil
        }
        var bestRecord = (recordmodel?.allObjects as? [RecordModel])?.first
        for item in recordmodel! {
            let record = item as! RecordModel
            if record.mTime < (bestRecord?.mTime)! {
                bestRecord = record
            }
        }
        return bestRecord
    }
}
