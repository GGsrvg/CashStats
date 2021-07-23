//
//  AddConsumptionViewModel.swift
//  CashStats
//
//  Created by GGsrvg on 01.07.2021.
//

import CoreData
import DB
import LDS

class AddCategoryViewModel: BaseViewModel {
    
    private var observation: NSKeyValueObservation?
    
    let fields: ObservableDataSourceOneDimension<AddCategoryContentType> = .init()
    
    lazy var nameTextField: TextFieldPresenter = .init(
        title: "Name",
        placeholder: nil,
        value: nil,
        keyboardType: .default
    )
    
    lazy var costsLimitTextField: TextFieldPresenter = .init(
        title: "Costs limit",
        placeholder: nil,
        value: nil,
        keyboardType: .decimalPad
    )
    
    lazy var typeSegmentedControl: SegmentControlPresenter = .init(
        segments: [
            .init(id: 0, title: "Month"),
            .init(id: 1, title: "Year")
        ]
    )
    
    lazy var selectColorWell: ColorWellPresenter = .init(
        title: "Select color",
        selectedColor: .red
    )
    
    required init() {
        super.init()
        
        fields.set([
            .textField(model: nameTextField),
            .textField(model: costsLimitTextField),
            .segmentedControl(model: typeSegmentedControl),
            .colorWell(model: selectColorWell)
        ])
    }
    
    func save() {
        guard let name = self.nameTextField.value,
              let periodLimit = Decimal(string: self.costsLimitTextField.value ?? "0"),
              let colorHEX = self.selectColorWell.selectedColor?.rgb()
        else { return }

        let typeSegment = self.typeSegmentedControl.segments[self.typeSegmentedControl.selectedId]
        
        let category = CategoryEntity(entity: .entity(forEntityName: "CategoryEntity", in: bl.db.context)!, insertInto: nil)
        category.name = name
        category.colorHEX = Int64(colorHEX)
        category.spentFunds = NSDecimalNumber(decimal: periodLimit * 0.23)
        category.fundsLimit = NSDecimalNumber(decimal: periodLimit)
        category.periodType = typeSegment.id == 0 ? "Month" : "Year"
        
        self.bl.category.add(models: [category])
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
