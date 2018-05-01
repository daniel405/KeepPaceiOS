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

@objc(RaceModel)
public class RaceModel: NSManagedObject {
    
    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
        mId = -1
        mName = ""
        mDistance = 0.0
        mMarkers = 0
        mAveragePace = 0.0
        mTime = 0
        mUnit = "km"
    }
    
}
