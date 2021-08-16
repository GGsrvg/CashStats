//
//  ConsumptionCase.swift
//  BL
//
//  Created by GGsrvg on 12.07.2021.
//

import Combine
import DTO

// for test
enum A: Error {
    case limit
}

public class ConsumptionCase {
    public func get(by category: DTO.Category, from position: Int, count: Int) -> AnyPublisher<[DTO.Consumption], Error> {
        return Deferred { Future<[DTO.Consumption], Error> { promise in
            do {
                let count = try BL.current.db.consumption.countAll()
                if count <= position {
                    throw A.limit
                }
                let models = try BL.current.db.consumption.fetch(by: category, from: position, count: count)
                promise(.success(models))
            } catch {
                promise(.failure(error))
            }
        } }.eraseToAnyPublisher()
    }
    
    public func save(model: DTO.Consumption) -> AnyPublisher<DTO.Consumption, Error> {
        return Deferred { Future<DTO.Consumption, Error> { promise in
            do {
                let savedCategory = try BL.current.db.consumption.save(consumption: model)
                promise(.success((savedCategory)))
            } catch {
                print(error)
                promise(.failure(error))
            }
        } }.eraseToAnyPublisher()
    }

    public func delete(model: DTO.Consumption) -> AnyPublisher<Void, Error> {
        return Deferred { Future<Void, Error> { promise in
            do {
                try BL.current.db.consumption.delete(consumption: model)
                promise(.success(()))
            } catch {
                promise(.failure(error))
            }
        } }.eraseToAnyPublisher()
    }
}
