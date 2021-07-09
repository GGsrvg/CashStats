//
//  AddConsumptionViewModel.swift
//  CashStats
//
//  Created by GGsrvg on 01.07.2021.
//

import Foundation
import DTO
import LDS

class AddConsumptionViewModel: BaseViewModel {
    
    private var observation: NSKeyValueObservation?
    
    let fields: ObservableDataSourceOneDimension<AddConsumptionContentType> = .init()
    
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
              let periodLimit = Decimal(string: self.costsLimitTextField.value ?? ""),
              let colorHEX = self.selectColorWell.selectedColor?.rgb()
        else { return }
        
        let typeSegment = self.typeSegmentedControl.segments[self.typeSegmentedControl.selectedId]
        
        let category = DTO.Category(
            name: name,
            colorHEX: colorHEX,
            spentFunds: periodLimit * 0.23,
            fundsLimit: periodLimit,
            periodType: typeSegment.id == 0 ? .month : .year
        )
        
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
