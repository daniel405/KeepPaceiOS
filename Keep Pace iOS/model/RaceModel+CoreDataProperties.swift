//
//  RaceModel+CoreDataProperties.swift
//  Keep Pace iOS
//
//  Created by Quincy on 2018-04-30.
//  Copyright © 2018 Daniel Katz. All rights reserved.
//
//

import Foundation
import CoreData


extension RaceModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RaceModel> {
        return NSFetchRequest<RaceModel>(entityName: "RaceModel")
    }

    @NSManaged public var mId: Int64
    @NSManaged public var mName: String?
    @NSManaged public var mDistance: Double
    @NSManaged public var mMarkers: Int64
    @NSManaged public var mAveragePace: Double
    @NSManaged public var mTime: Int64
    @NSManaged public var mUnit: String?
    @NSManaged public var recordmodel: NSSet?

}

// MARK: Generated accessors for recordmodel
extension RaceModel {

    @objc(addRecordmodelObject:)
    @NSManaged public func addToRecordmodel(_ value: RecordModel)

    @objc(removeRecordmodelObject:)
    @NSManaged public func removeFromRecordmodel(_ value: RecordModel)

    @objc(addRecordmodel:)
    @NSManaged public func addToRecordmodel(_ values: NSSet)

    @objc(removeRecordmodel:)
    @NSManaged public func removeFromRecordmodel(_ values: NSSet)

}
