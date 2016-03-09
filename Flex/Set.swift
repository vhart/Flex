//
//  Set.swift
//  Flex
//
//  Created by Varindra Hart on 3/6/16.
//  Copyright © 2016 Varindra Hart. All rights reserved.
//

import Foundation
import CoreData


class Set: NSManagedObject {

    convenience init(context: NSManagedObjectContext){
        let entityDescription = NSEntityDescription.entityForName("Set",
            inManagedObjectContext: context)
        self.init(entity: entityDescription!, insertIntoManagedObjectContext: context)

        isWarmup = NSNumber(bool: false)
        
    }

    func save() {
        do {
            try self.managedObjectContext?.save()
        }   catch {
            fatalError("\(error)")
        }
    }
}
