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
        for i in stride(from: 0, to: Races.count, by: 1) {
            if !checkIfIdExists(managedObjectContext: context, _entityName: entityName, idToLookFor: i) {
                let raceModel = RaceModel(entity: entity!, insertInto: context)
                raceModel.mId = Int64(i)
                raceModel.mName = Races[i].Name
                raceModel.mDistance = Races[i].Distance
                raceModel.mMarkers = Int64(Races[i].Markers)
                raceModel.mAveragePace = 0.0
                raceModel.mTime = 0
                raceModel.mUnit = "km"
                do {
                    try context.save()
                } catch {
                    let nserror = error as NSError
                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                }
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
            //Else, print the data and do nothing else
            else
            {
                let myObject = try managedObjectContext.fetch(fetchRequest) as! [RaceModel]
                printRaceModel(raceModel: myObject[0])
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
        print("=============")
    }
}
