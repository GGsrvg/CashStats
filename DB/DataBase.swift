//
//  DataBase.swift
//  DB
//
//  Created by GGsrvg on 02.07.2021.
//

import CoreData

public final class DataBase {
    public static let current = DataBase()
    
    let coreDataStack: CoreDataStack
    
    init() {
        self.coreDataStack = CoreDataStack()
    }
    
    public var context: NSManagedObjectContext { get {
        return coreDataStack.context
    } }
    
    public func save() throws {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                context.rollback()
                throw error
            }
        }
    }
    
    public func delete<T: Entity>(type: T.Type, predicate: NSPredicate?) throws {
        let request = type.fetchRequest()
        request.predicate = predicate
        
        let entities = try context.fetch(request) as! [T]
        
        entities.forEach {
            context.delete($0)
        }
        
        try save()
    }
    
    public func fetch<T: Entity>(type: T.Type, predicate: NSPredicate? = nil) throws -> [T] {
        let request = type.fetchRequest()
        request.predicate = predicate
        return try context.fetch(request) as! [T]
    }
    
    public func count<T: Entity>(type: T.Type, predicate: NSPredicate? = nil) throws -> Int {
        let request = type.fetchRequest()
        request.predicate = predicate
        return try context.count(for: request)
    }
}
