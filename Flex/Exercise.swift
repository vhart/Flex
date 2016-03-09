//
//  Exercise.swift
//  Flex
//
//  Created by Varindra Hart on 3/6/16.
//  Copyright © 2016 Varindra Hart. All rights reserved.
//

import Foundation
import CoreData


class Exercise: NSManagedObject {

    convenience init(context: NSManagedObjectContext){
        let entityDescription = NSEntityDescription.entityForName("Exercise",
            inManagedObjectContext: context)
        self.init(entity: entityDescription!, insertIntoManagedObjectContext: context)
    }

    func save() {
        do {
            try self.managedObjectContext?.save()
        }   catch {
            fatalError("\(error)")
        }
    }

    func addSet(nextSet: Set) {
        if let allSets = sets as? NSMutableOrderedSet {
            allSets.addObject(nextSet)
            sets = allSets
        } else {
            let allSets = NSMutableOrderedSet.init(object: nextSet)
            sets = allSets
        }
    }
}
