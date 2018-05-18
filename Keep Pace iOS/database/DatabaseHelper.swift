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
        RaceSeed(_Name: "5K", _Distance: 5.0, _Markers: 4),
        RaceSeed(_Name: "10K", _Distance: 10.0, _Markers: 9),
        RaceSeed(_Name: "Half Marathon", _Distance: 21.1, _Markers: 20),
        RaceSeed(_Name: "Full Marathon", _Distance: 42.2, _Markers: 41),
        RaceSeed(_Name: "Grouse Grind", _Distance: 2.2, _Markers: 3),
        RaceSeed(_Name: "437 Steps", _Distance: 0.3, _Markers: 8),
        RaceSeed(_Name: "457 Steps", _Distance: 0.29, _Markers: 9)
    ]
    
    //Dummy Data for seeding race
    let Records: [RecordSeed] = [
        RecordSeed(_AveragePace: 1.0, _Time: 2, _Date: "2018-01-RON"),
        RecordSeed(_AveragePace: 9.1, _Time: 111111111, _Date: "2018-02-02"),
        RecordSeed(_AveragePace: 2.1, _Time: 111112, _Date: "2018-03-03"),
        RecordSeed(_AveragePace: 2.1, _Time: 11111112, _Date: "2018-03-03"),
        RecordSeed(_AveragePace: 2.1, _Time: 11112, _Date: "2018-03-03"),
        RecordSeed(_AveragePace: 2.1, _Time: 113441112, _Date: "2018-03-03")
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
        
        //var test: RaceModel?
        
        for i in stride(from: 0, to: Races.count, by: 1) {
            if !checkIfIdExists(managedObjectContext: context, _entityName: entityName, idToLookFor: i) {
                let raceModel = RaceModel(entity: entity!, insertInto: context)
                do {
                    try raceModel.validateAndInsert(value: Int64(i), forKey: "mId")
                    try raceModel.validateAndInsert(value: Races[i].Name, forKey: "mName")
                    try raceModel.validateAndInsert(value: Races[i].Distance, forKey: "mDistance")
                    try raceModel.validateAndInsert(value: Races[i].Markers, forKey: "mMarkers")
                } catch RaceModel.RaceModelError.objectIsNil(let msg){
                    print(msg)
                    continue
                } catch RaceModel.RaceModelError.invalidInput(let msg) {
                    print(msg)
                    continue
                } catch {
                    print("Problem with creating RaceModel")
                    continue
                }
                  seedRecord(raceModel: raceModel)
//                printRaceModel(raceModel: raceModel)
                do {
                    try context.save()
                } catch {
                    let nserror = error as NSError
                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                }
                //test = raceModel
            }
        }
        
    }
    
    //Seeds Race Data with Dummy Record Data
    func seedRecord(raceModel: RaceModel) {
        let entityName = "RecordModel"
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: context)
        for i in stride(from: 0, to: Records.count, by: 1) {
            let recordModel = RecordModel(entity: entity!, insertInto: context)
            do {
                try recordModel.validateAndInsert(value: Int64(i), forKey: "mId")
                try recordModel.validateAndInsert(value: Records[i].AveragePace, forKey: "mAveragePace")
                try recordModel.validateAndInsert(value: Records[i].Time, forKey: "mTime")
                try recordModel.validateAndInsert(value: Records[i].mDate, forKey: "mDate")
            } catch RaceModel.RaceModelError.objectIsNil(let msg){
                print(msg)
                continue
            } catch RaceModel.RaceModelError.invalidInput(let msg) {
                print(msg)
                continue
            } catch {
                print("Problem with creating RecordModel")
                continue
            }
            raceModel.addToRecordmodel(recordModel)
            print("Added Record To RaceModel")
//            if i == 1 {
//                raceModel.removeFromRecordmodel(recordModel)
//            }
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
    
    //Finds Race model in CoreData and returns it if it exists
    func getRaceModel(idToLookFor: Int) -> RaceModel? {
        let entityName = "RaceModel"
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: context)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let predicate = NSPredicate(format: "mId = \(idToLookFor)")
        fetchRequest.predicate = predicate
        do {
            //If result returned 0, there was no such entry in CoreData
            let result = try context.count(for: fetchRequest)
            if result != 0 {
                let raceModel = try context.fetch(fetchRequest) as? [RaceModel]
                return raceModel?[0]
            }
        } catch {
            fatalError("Something went wrong")
        }
        return nil
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
            print("-------------")
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
