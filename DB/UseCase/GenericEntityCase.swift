//
//  GenericEntityCase.swift
//  DB
//
//  Created by GGsrvg on 02.07.2021.
//

import CoreData
import DTO

final public class GenericEntityCase<EntityObject: ConvertableEntity>: EntityCase {
    
    public func get(predicate: NSPredicate?) throws -> [EntityObject.DTObject] {
        // create request
        let request = EntityObject.fetchRequest()
//        request.predicate = predicate
        // get entities
        let entities = try context.fetch(request)
        // convert entity to DTO
        let returnObjects: [EntityObject.DTObject] = entities.compactMap { ($0 as! EntityObject).convertToDTO() }
        // return 
        return returnObjects
    }
    
    public func add(models: [EntityObject.DTObject]) throws {
        if models.isEmpty {
            fatalError("models is empty")
        }
        
        models.forEach { model in
            let entity = EntityObject(context: context)
            entity.set(by: model)
        }
        try save()
    }
    
    public func update(model: EntityObject.DTObject, predicate: NSPredicate?) throws {
        let request = NSFetchRequest<EntityObject>()
        request.predicate = predicate

        let entities: [EntityObject] = try context.fetch(request)

        entities.forEach { $0.set(by: model) }

        try save()
    }

    public func delete(predicate: NSPredicate?) throws {
        let request = NSFetchRequest<EntityObject>()
        request.predicate = predicate
        
        let entities = try context.fetch(request)
        
        entities.forEach {
            context.delete($0)
        }
        
        try save()
    }
}
