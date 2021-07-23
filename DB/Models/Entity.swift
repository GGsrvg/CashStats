//
//  Entity.swift
//  DB
//
//  Created by GGsrvg on 21.07.2021.
//

import CoreData

public protocol Entity where Self : NSManagedObject {
//    func save() throws
}

//public extension Entity {
//    func save() throws {
//        guard let context = self.managedObjectContext
//        else { fatalError("managedObjectContext is nil") }
//
//        if context.hasChanges {
//            do {
//                try context.save()
//            } catch {
//                context.rollback()
//                throw error
//            }
//        }
//    }
//}
