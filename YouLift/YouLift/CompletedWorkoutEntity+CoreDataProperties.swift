//
//  CompletedWorkoutEntity+CoreDataProperties.swift
//  YouLift
//
//  Created by Andrew Garland on 5/8/17.
//  Copyright © 2017 rbuzby. All rights reserved.
//

import Foundation
import CoreData

//  automatically generated by Xcode - see CompletedWorkoutEntity+CoreDataClass
extension CompletedWorkoutEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CompletedWorkoutEntity> {
        return NSFetchRequest<CompletedWorkoutEntity>(entityName: "CompletedWorkoutEntity")
    }

    @NSManaged public var name: String
    @NSManaged public var date: Date
    @NSManaged public var duration: Double
    //@NSManaged public var exerciseArray: NSObject

}
