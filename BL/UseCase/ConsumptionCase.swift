//
//  ConsumptionCase.swift
//  BL
//
//  Created by GGsrvg on 12.07.2021.
//

import Combine
import DTO

public class ConsumptionCase {
    public func get(by category: DTO.Category, from position: Int, count: Int) -> AnyPublisher<[DTO.Consumption], Error> {
        return Deferred { Future<[DTO.Consumption], Error> { promise in
            do {
                let count = try BL.current.db.consumption.countAll()
                if count <= position {
                    throw BLError.limit
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
//                if var category = try BL.current.db.category.fetch()
//                    .first(where: { $0.id == model.categoryId }) {
//                    category.spentFunds += model.price
//                    _ = try BL.current.db.category.save(category: category)
//                    let savedConsumption = try BL.current.db.consumption.save(consumption: model)
//                    promise(.success((savedConsumption)))
//                } else {
//                    throw BLError.categoryNotFound
//                }
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
//                if var category = try BL.current.db.category.fetch()
//                    .first(where: { $0.id == model.categoryId }) {
//                    category.spentFunds -= model.price
//                    _ = try BL.current.db.category.save(category: category)
//                    try BL.current.db.consumption.delete(consumption: model)
//                    promise(.success(()))
//                } else {
//                    throw BLError.categoryNotFound
//                }
                try BL.current.db.consumption.delete(consumption: model)
                promise(.success(()))
            } catch {
                promise(.failure(error))
            }
        } }.eraseToAnyPublisher()
    }
}
