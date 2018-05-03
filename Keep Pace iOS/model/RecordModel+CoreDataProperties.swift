//
//  RecordModel+CoreDataProperties.swift
//  Keep Pace iOS
//
//  Created by Quincy on 2018-04-30.
//  Copyright © 2018 Daniel Katz. All rights reserved.
//
//

import Foundation
import CoreData


extension RecordModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RecordModel> {
        return NSFetchRequest<RecordModel>(entityName: "RecordModel")
    }

    @NSManaged public var mId: Int64
    @NSManaged public var mAveragePace: Double
    @NSManaged public var mTime: Int64
    @NSManaged public var mDate: String?
    @NSManaged public var racemodel: RaceModel?

}
