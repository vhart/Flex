//
//  Set+CoreDataProperties.swift
//  Flex
//
//  Created by Varindra Hart on 3/6/16.
//  Copyright © 2016 Varindra Hart. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Set {

    @NSManaged var isWarmup: NSNumber?
    @NSManaged var reps: NSNumber?
    @NSManaged var weight: NSNumber?
    @NSManaged var exercise: Exercise?

}
