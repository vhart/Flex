//
//  Workout.swift
//  Flex
//
//  Created by Varindra Hart on 3/6/16.
//  Copyright © 2016 Varindra Hart. All rights reserved.
//

import Foundation
import CoreData


class Workout: NSManagedObject {

    convenience init(context: NSManagedObjectContext){
        let entityDescription = NSEntityDescription.entityForName("Workout",
            inManagedObjectContext: context)
        self.init(entity: entityDescription!, insertIntoManagedObjectContext: context)
    }

    func save() {
        do {
            try self.managedObjectContext?.save()
        }   catch {
            print("\(error)")
        }
    }
}
