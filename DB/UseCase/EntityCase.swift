//
//  EntityCase.swift
//  DB
//
//  Created by GGsrvg on 02.07.2021.
//

import Foundation
import CoreData

public class EntityCase {
    weak var coreDataStack: CoreDataStack!
    
    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
    }
}

extension EntityCase {
    var context: NSManagedObjectContext
    {
        get {
            return coreDataStack.context
        }
    }
    
    func save() throws {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                context.rollback()
                throw error
            }
        }
    }
}
