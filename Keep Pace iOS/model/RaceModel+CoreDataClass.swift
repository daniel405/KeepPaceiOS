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
    
    //Enum containing the errors
    enum RaceModelError: Error {
        case objectIsNil(msg: String)
        case invalidInput(msg: String)
    }
    
    //Mile conversion per 1 km
    let milePerKm: Double = 0.621371
    
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
    
    //Returns the distance in miles
    func getDistanceInMiles() -> Double {
        return mDistance * milePerKm
    }
    
    //Returns the average pace in miles
    func getAveragePaceInMiles() -> Double {
        return mAveragePace * milePerKm
    }
    
    //Validates inputs
    func validateAndInsert(value: Any?, forKey: String) throws {
        if forKey == "mId" {
            guard let id = value as? Int64 else {
                throw RaceModelError.objectIsNil(msg: "Nothing in mId")
            }
            if id < 0 {
                throw RaceModelError.invalidInput(msg: "mId cannot be smaller than 0")
            } else {
                mId = id
            }
        } else if forKey == "mName" {
            guard let name = value as? String else {
                throw RaceModelError.objectIsNil(msg: "Nothing in mName")
            }
            if name.isEmpty {
                throw RaceModelError.invalidInput(msg: "mName cannot be empty")
            } else {
                mName = name
            }
        } else if forKey == "mDistance" {
            guard let distance = value as? Double else {
                throw RaceModelError.objectIsNil(msg: "Nothing in distance")
            }
            if distance < 0.0 {
                throw RaceModelError.invalidInput(msg: "Distance cannot be smaller than 0")
            } else {
                mDistance = distance
            }
        } else if forKey == "mMarkers" {
            guard let markers = value as? Int64 else {
                throw RaceModelError.objectIsNil(msg: "Nothing in mMarkers")
            }
            if markers < 0 {
                throw RaceModelError.invalidInput(msg: "mMarkers cannot be smaller than 0")
            } else {
                mMarkers = markers
            }
        }
    }
}
