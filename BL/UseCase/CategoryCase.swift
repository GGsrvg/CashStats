//
//  CategoryCase.swift
//  BL
//
//  Created by GGsrvg on 04.07.2021.
//

import Combine
import DTO
//import DB

public class CategoryCase {
    public func get(predicate: NSPredicate? = nil) -> AnyPublisher<[DTO.Category], Error> {
        return Deferred { Future<[DTO.Category], Error> { promise in
            do {
                let models = try BL.current.db.category.fetch()
                promise(.success(models))
            } catch {
                promise(.failure(error))
            }
        } }.eraseToAnyPublisher()
    }
    
    public func save(model: DTO.Category) -> AnyPublisher<DTO.Category, Error> {
        return Deferred { Future<DTO.Category, Error> { promise in
            do {
                let savedCategory = try BL.current.db.category.save(category: model)
                promise(.success((savedCategory)))
            } catch {
                print(error)
                promise(.failure(error))
            }
        } }.eraseToAnyPublisher()
    }

    public func delete(model: DTO.Category) -> AnyPublisher<Void, Error> {
        return Deferred { Future<Void, Error> { promise in
            do {
                try BL.current.db.category.delete(category: model)
                promise(.success(()))
            } catch {
                promise(.failure(error))
            }
        } }.eraseToAnyPublisher()
    }
}
