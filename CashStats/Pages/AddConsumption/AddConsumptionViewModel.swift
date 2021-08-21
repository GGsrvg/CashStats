//
//  AddConsumptionViewModel.swift
//  CashStats
//
//  Created by GGsrvg on 13.07.2021.
//

import LDS
import DTO

class AddConsumptionViewModel: BaseViewModel {
    
    let fields: ObservableDataSourceOneDimension<AddConsumptionContentType> = .init()
    
    private let name = TextFieldPresenter(
        title: "Title",
        placeholder: "Name of consumption",
        value: nil,
        keyboardType: .default
    )
    
    private let price = TextFieldPresenter(
        title: "Price",
        placeholder: "Product price",
        value: nil,
        keyboardType: .decimalPad,
        textFieldDelegate: NumberFormatterMask.shared
    )
    
    private let date = DatePresenter(date: Date())
    
    private let category: DTO.Category
    
    var consumption: DTO.Consumption? { didSet {
        name.value = consumption?.name
        price.value = consumption?.price.optimalString
        date.date = consumption?.date ?? Date()
    }}
    
    required init(category: DTO.Category) {
        self.category = category
        super.init()
        fields.set([
            .textField(model: name),
            .textField(model: price),
            .date(model: date),
        ])
    }
    
    required init() {
        fatalError("init() has not been implemented")
    }
    
    func save() {
        guard let categoryId = self.category.id,
              let name = self.name.value,
              let price = Double(self.price.value ?? "0"),
              !name.isEmpty && price != 0
        else { return }
        
        let date = self.date.date
        
        let consumption = DTO.Consumption(
            id: self.consumption?.id,
            categoryId: categoryId,
            date: date,
            name: name,
            price: price
        )
        
        self.bl.consumption.save(model: consumption)
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .sink { [weak self] end in
                switch end {
                case .finished:
                    self?.coordinator.popTo()
                case .failure(let error):
                    print("ERROR \(error.localizedDescription)")
                }
            } receiveValue: { output in }
            .store(in: &bag)
    }
}
