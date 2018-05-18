//
//  RecordModel+CoreDataClass.swift
//  Keep Pace iOS
//
//  Created by Quincy on 2018-04-30.
//  Copyright © 2018 Daniel Katz. All rights reserved.
//
//

import Foundation
import CoreData

//@objc(RecordModel)
public class RecordModel: NSManagedObject {
    
    
    //Enum containing the errors
    enum RaceModelError: Error {
        case objectIsNil(msg: String)
        case invalidInput(msg: String)
    }
        
    //Mile conversion per 1 km
    let milePerKm: Double = 0.621371
    
    //Data Initializer Method for Record Model
    public override func awakeFromInsert() {
        mId = -1
        mAveragePace = 0.0
        mTime = 0
        mDate = ""
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
        } else if forKey == "mAveragePace" {
            guard let averagePace = value as? Double else {
                throw RaceModelError.objectIsNil(msg: "Nothing in mAveragePace")
            }
            if averagePace < 0 {
                throw RaceModelError.invalidInput(msg: "mAveragePace cannot be smaller than 0")
            } else {
                mAveragePace = averagePace
            }
        } else if forKey == "mTime" {
            guard let time = value as? Int64 else {
                throw RaceModelError.objectIsNil(msg: "Nothing in mTime")
            }
            if time < 0 {
                throw RaceModelError.invalidInput(msg: "mTime cannot be smaller than 0")
            } else {
                mTime = time
            }
        }  else if forKey == "mDate" {
            guard let date = value as? String else {
                throw RaceModelError.objectIsNil(msg: "Nothing in mDate")
            }
            if stringTest(string: date) {
                mDate = date
            } else {
                throw RaceModelError.invalidInput(msg: "mDate did not match format")
            }
        }
    }
    
    //Regex that validates date
    func stringTest(string: String) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: "^[0-9]{4}-(((0[13578]|(10|12))-(0[1-9]|[1-2][0-9]|3[0-1]))|(02-(0[1-9]|[1-2][0-9]))|((0[469]|11)-(0[1-9]|[1-2][0-9]|30)))$", options: [])
            if regex.numberOfMatches(in: string, options: [], range: NSMakeRange(0, string.count)) == 1 {
                return true
            }
        } catch {
            print("Regex didn't work")
        }
        return false
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
}
