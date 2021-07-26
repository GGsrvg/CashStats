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
    
    var consumption: DTO.Consumption?
    
    private let name = TextFieldPresenter(
        title: "name",
        placeholder: "01.01.2020",
        value: nil,
        keyboardType: .default
    )
    
    private let price = TextFieldPresenter(
        title: "price",
        placeholder: "300",
        value: nil,
        keyboardType: .decimalPad
    )
    
    private let date = DatePresenter(date: Date())
    
    private let category: DTO.Category
    
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
//            ConsumptionEntity(entity: .entity(forEntityName: "ConsumptionEntity", in: bl.db.context)!, insertInto: nil)
//        consumption.name = name
//        consumption.price = NSDecimalNumber(decimal: price)
//        consumption.date = date
        
        
        self.bl.consumption.save(model: consumption)
//            .add(models: [.init(id: "", date: date, name: name, price: price * -1)], to: category)
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
