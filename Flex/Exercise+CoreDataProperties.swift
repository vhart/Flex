//
//  Exercise+CoreDataProperties.swift
//  Flex
//
//  Created by Varindra Hart on 3/20/16.
//  Copyright © 2016 Varindra Hart. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Exercise {

    @NSManaged var name: String?
    @NSManaged var notes: String?
    @NSManaged var repRangeMin: NSNumber?
    @NSManaged var repRangeMax: NSNumber?
    @NSManaged var sets: NSOrderedSet?
    @NSManaged var workout: Workout?

}
