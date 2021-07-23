//
//  ConsumptionCase.swift
//  BL
//
//  Created by GGsrvg on 12.07.2021.
//

import Combine
import DB
import CoreData

public class ConsumptionCase {
    public func get(category: CategoryEntity, predicate: NSPredicate? = nil) -> AnyPublisher<[ConsumptionEntity], Error> {
        return Deferred { Future<[ConsumptionEntity], Error> { promise in
            do {
                var subPredicates = [
                    NSPredicate(format: "%K = %@", #keyPath(ConsumptionEntity.category), category)
                ]
                
                if let predicate = predicate {
                    subPredicates.append(predicate)
                }
                
                let compoundPredicate = NSCompoundPredicate(type: .and, subpredicates: subPredicates)
                
                let models = try BL.current.db.fetch(
                    type: ConsumptionEntity.self,
                    predicate: compoundPredicate
                )
                promise(.success(models))
            } catch {
                promise(.failure(error))
            }
        } }.eraseToAnyPublisher()
    }
    
    public func add(models: [ConsumptionEntity], to category: CategoryEntity) -> AnyPublisher<Void, Error> {
        return Deferred { Future<Void, Error> { promise in
            do {
                models.forEach {
                    BL.current.db.context.insert($0)
                    category.addToConsumptions($0)
                }
                try BL.current.db.save()
                promise(.success(()))
            } catch {
                promise(.failure(error))
            }
        } }.eraseToAnyPublisher()
    }
    
    public func update() -> AnyPublisher<Void, Error> {
        return Deferred { Future<Void, Error> { promise in
            do {
                try BL.current.db.save()
                promise(.success(()))
            } catch {
                promise(.failure(error))
            }
        } }.eraseToAnyPublisher()
    }
    
    public func delete(models: [ConsumptionEntity]) -> AnyPublisher<Void, Error> {
        return Deferred { Future<Void, Error> { promise in
            do {
                models.forEach { BL.current.db.context.delete($0) }
                try BL.current.db.save()
                promise(.success(()))
            } catch {
                promise(.failure(error))
            }
        } }.eraseToAnyPublisher()
    }
}
