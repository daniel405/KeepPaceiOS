//
//  DatabaseHelper.swift
//  Keep Pace iOS
//
//  Created by Quincy on 2018-04-30.
//  Copyright © 2018 Daniel Katz. All rights reserved.
//

import CoreData
import Foundation
import UIKit

//This class will be used for 
class DatabaseHelper {
    
    //Number of Races
    static let numRaces = 7
    
    //Dummy Data for seeding race
    let Races: [RaceSeed] = [
        RaceSeed(_Name: "5K", _Distance: 5.0, _Markers: 5),
        RaceSeed(_Name: "10K", _Distance: 10.0, _Markers: 10),
        RaceSeed(_Name: "Half Marathon", _Distance: 21.1, _Markers: 21),
        RaceSeed(_Name: "Full Marathon", _Distance: 42.2, _Markers: 42),
        RaceSeed(_Name: "Grouse Grind", _Distance: 2.2, _Markers: 4),
        RaceSeed(_Name: "457 Steps", _Distance: 0.29, _Markers: 10),
        RaceSeed(_Name: "437 Steps", _Distance: 0.3, _Markers: 9)
    ]
    
    //Dummy Data for seeding race
    let Records: [RecordSeed] = [
        RecordSeed(_AveragePace: 1.0, _Time: 2, _Date: "Here"),
        RecordSeed(_AveragePace: 9.1, _Time: 5, _Date: "There"),
        RecordSeed(_AveragePace: 2.1, _Time: 19, _Date: "Everywhere")
    ]
    
    
    init() {
        //Initialize this database helper with seedRace
        seedRace()
    }
    
    //Seeds Race Data into CoreData
    func seedRace() {
        let entityName = "RaceModel"
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: context)
        
        var test: RaceModel?
        
        for i in stride(from: 0, to: Races.count, by: 1) {
            if !checkIfIdExists(managedObjectContext: context, _entityName: entityName, idToLookFor: i) {
                let raceModel = RaceModel(entity: entity!, insertInto: context)
                raceModel.mId = Int64(i)
                raceModel.mName = Races[i].Name
                raceModel.mDistance = Races[i].Distance
                raceModel.mMarkers = Int64(Races[i].Markers)
                seedRecord(raceModel: raceModel)
                printRaceModel(raceModel: raceModel)
                do {
                    try context.save()
                } catch {
                    let nserror = error as NSError
                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                }
                test = raceModel
            }

        }
        
        //Print worst and best methods
        if let worstRecord = test?.getWorstRecord() {
            printRecordModel(recordModel: worstRecord)
        }
        if let bestRecord = test?.getBestRecord() {
             printRecordModel(recordModel:bestRecord)
        }
    }
    
    //Update passed in RaceData in CoreData
    func updateRaceModel(raceModel: RaceModel) {
        
    }
    
    //Seeds Race Data with Dummy Record Data
    func seedRecord(raceModel: RaceModel) {
        let entityName = "RecordModel"
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: context)
        for i in stride(from: 0, to: Records.count, by: 1) {
            let recordModel = RecordModel(entity: entity!, insertInto: context)
            recordModel.mId = Int64(i)
            recordModel.mAveragePace = Records[i].AveragePace
            recordModel.mTime = Records[i].Time
            recordModel.mDate = Records[i].mDate
            raceModel.addToRecordmodel(recordModel)
            if i == 1 {
                raceModel.removeFromRecordmodel(recordModel)
            }
        }
    }
 
    //Checks to see if Id exists and returns false if not found and true ifand id was found
    func checkIfIdExists(managedObjectContext: NSManagedObjectContext, _entityName: String, idToLookFor: Int) -> Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: _entityName)
        let predicate = NSPredicate(format: "mId = \(idToLookFor)")
        fetchRequest.predicate = predicate
        do {
            //If result returned 0, there was no such entry in CoreData
            let result = try managedObjectContext.count(for: fetchRequest)
            if result == 0 {
                return false
            }
        } catch {
            fatalError("Something went wrong")
        }
        return true
    }
    
    //Prints a RaceModel
    func printRaceModel(raceModel: RaceModel) {
        print("Id: " + String(raceModel.mId))
        print("Name: " + raceModel.mName!)
        print("Distance: " + String(raceModel.mDistance))
        print("Markers: " + String(raceModel.mMarkers))
        print("Average Pace: " + String(raceModel.mAveragePace))
        print("Time: " + String(raceModel.mTime))
        print("Units: " + raceModel.mUnit!)
        for item in raceModel.recordmodel! {
            let record = item as! RecordModel
            printRecordModel(recordModel: record)
            print("-------------")

        }
        print("=============")
    }
    
    func printRecordModel(recordModel: RecordModel) {
        print("Id: " + String(recordModel.mId))
        print("Average: " + String(recordModel.mAveragePace))
        print("Time: " + String(recordModel.mTime))
        print("Date: " + recordModel.mDate!)
    }
}
