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
        mUnit = "KM"
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
    
//    //Returns the distance in miles
//    func getDistanceInMiles() -> Double {
//        return mDistance * milePerKm
//    }
//
//    //Returns the average pace in miles
//    func getAveragePaceInMiles() -> Double {
//        return mAveragePace * milePerKm
//    }
    
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
    
    //Get current pace
    func getCurrentPace(currentMarker: Int64, currentTime: Int64) -> Double {
        let currentDistance = currentMarker
        return Double(currentDistance / currentMarker)
    }
    
    //Get estimated time to finish
    func getEstimateTime(pace: Double) -> Int64 {
        if (mUnit?.caseInsensitiveCompare("Mile") == ComparisonResult.orderedSame) && (mName?.caseInsensitiveCompare("Half Marathon") == ComparisonResult.orderedSame){
            return Int64(13.1 / pace)
        }
        
        if(mUnit?.caseInsensitiveCompare("Mile") == ComparisonResult.orderedSame) && (mName?.caseInsensitiveCompare("Full Marathon") == ComparisonResult.orderedSame){
            return Int64(26.2 / pace)
        }
        
        return Int64(mDistance / pace)
    }
    
    //Converts Miles to kilometers
    func convertToMiles(kilometer: Double) -> Double {
        return kilometer * milePerKm
    }
    
    //Converts Kilometers to miles
    func convertToKM(miles: Double) -> Double {
        return miles / milePerKm
    }
    
    //Get marker name
    func getMarkerName(count: Int64) -> String{
        if count == mMarkers {
            return "Finish"
        }
        
        if count <= 0 || count > mMarkers {
            return ""
        }
        
        if (mUnit?.caseInsensitiveCompare("Mile") == ComparisonResult.orderedSame) {
            if ((mName?.caseInsensitiveCompare("Half Marathon") == ComparisonResult.orderedSame) || (mName?.caseInsensitiveCompare("Full Marathon") == ComparisonResult.orderedSame)) {
                return String(count) + "MI"
            }
        }
        
        return String(count) + "K"
    }
    
    //Converts ms to hh:mm:ss or mm:ss.ss
    func timeTextFormat(ms: Int64) -> String {
        let msec = Int64(ms / 10) % 100
        var sec = Int64(ms / 1000)
        var min = sec / 60
        let hour = min / 60
        sec = sec % 60
        min = min % 60
        
        if (hour > 0) {
            return String(format: "%02d:%02d:%02d", hour, min, min)
        }
        
        return String(format: "%02d:%02d:%02d", hour, min, msec)
    }
    
    //Converts estimates time to String
    func etimateTimeText(pace: Double) -> String {
        return timeTextFormat(ms: getEstimateTime(pace: pace))
    }
    
    //Converts Best Time To String
    func getTimeText() -> String {
        return timeTextFormat(ms: mTime)
    }
    
    //Removes oldest record and adds new one
    func removeAndAdd(recordModelToAdd: RecordModel) {
        if (recordmodel?.count)! >= 10 {
            self.removeFromRecordmodel(getWorstRecord()!)
            self.addToRecordmodel(recordModelToAdd)
        } else {
            self.addToRecordmodel(recordModelToAdd)
        }
    }
    
    //Returns variables as int
    func getAsInt(variableToGet: String) -> Int {
        if (variableToGet.caseInsensitiveCompare("mTime") == ComparisonResult.orderedSame) {
            return Int(mTime)
        } else if (variableToGet.caseInsensitiveCompare("mId") == ComparisonResult.orderedSame) {
            return Int(mId)
        } else if (variableToGet.caseInsensitiveCompare("mMarkers") == ComparisonResult.orderedSame) {
            return Int(mMarkers)
        }
        
        return 0
    }
}
