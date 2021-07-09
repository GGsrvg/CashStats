//
//  CategoryCase.swift
//  BL
//
//  Created by GGsrvg on 04.07.2021.
//

import Combine
import DTO

public class CategoryCase {
    public func get() -> AnyPublisher<[DTO.Category], Error> {
        return Deferred {
            Future<[DTO.Category], Error> { promise in
                do {
                    let models = try BL.current.db.categoryCase.get(predicate: nil)
                    promise(.success(models))
                } catch {
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    public func add(models: [DTO.Category]) -> AnyPublisher<Void, Error> {
        return Deferred {
            Future<Void, Error> { promise in
                do {
                    try BL.current.db.categoryCase.add(models: models)
                    promise(.success(()))
                } catch {
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
}
