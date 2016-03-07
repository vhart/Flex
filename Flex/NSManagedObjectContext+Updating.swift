//
//  NSManagedObjectContext+Updating.swift
//  Flex
//
//  Created by Varindra Hart on 3/6/16.
//  Copyright © 2016 Varindra Hart. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObjectContext {

    func saveContext() {
        do{
            try self.save()
        }
        catch{
            fatalError("\(error)")
        }
    }

}