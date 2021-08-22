//
//  CategoiesViewModel.swift
//  CashStats
//
//  Created by GGsrvg on 29.06.2021.
//

import DTO
import Combine
import LDS

class CategoiesViewModel: BaseViewModel {
    
    let categories: ObservableDataSourceOneDimension<DTO.Category> = .init()
    
    @Published
    var contentState: ListContentState.TypeState = .content
    
    private var isFirstLoad = true
    
    required init() {
        super.init()
    }
    
    func load() {
        if isFirstLoad {
            contentState = .load
            isFirstLoad = false
        }
        
        self.bl.category.get()
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .sink { fail in
                switch fail {
                case .finished:
                    self.contentState = self.categories.array.isEmpty ?
                        .error(title: "Empty", description: "No categories added. Click \"+\" to add.") : .content
                case .failure(let error):
                    self.contentState = .error(
                        title: "Error",
                        description: error.localizedDescription
                    )
                }
            } receiveValue: { value in
                self.categories.set(value)
            }.store(in: &bag)
    }
    
    func delete(indexPath: IndexPath) {
        func deleteRequest() {
            let category = self.categories.array[indexPath.row]
            self.bl.category.delete(model: category)
                .subscribe(on: DispatchQueue.global())
                .receive(on: DispatchQueue.main)
                .sink { fail in
                    switch fail {
                    case .finished:
                        print("finished")
                    case .failure(let error):
                        print(error)
                    }
                } receiveValue: { value in
                    self.categories.removeRow(at: indexPath.row)
                }.store(in: &bag)
        }
        
        DI.alertCoordinator.alert(
            title: "Delete category?",
            message: "After that, you will not be able to restore the category.",
            preferredStyle: .alert,
            actions: [
                .init(
                    title: "Yes",
                    style: .cancel,
                    handler: { action in
                        deleteRequest()
                    }
                ),
                .init(
                    title: "No",
                    style: .default,
                    handler: nil
                )
            ]
        )
    }
}

