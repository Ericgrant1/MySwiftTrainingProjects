//
//  Meal+CoreDataProperties.swift
//  MyMealTime
//
//  Created by Eric Grant on 01.02.2020.
//  Copyright © 2020 Eric Grant. All rights reserved.
//
//

import Foundation
import CoreData


extension Meal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Meal> {
        return NSFetchRequest<Meal>(entityName: "Meal")
    }

    @NSManaged public var date: Date?
    @NSManaged public var person: Person?

}
