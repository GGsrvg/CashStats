//
//  AddConsumptionViewModel.swift
//  CashStats
//
//  Created by GGsrvg on 01.07.2021.
//

import DTO
import LDS

class AddCategoryViewModel: BaseViewModel {
    
    private var observation: NSKeyValueObservation?
    
    let fields: ObservableDataSourceOneDimension<AddCategoryContentType> = .init()
    
    lazy var nameTextField: TextFieldPresenter = .init(
        title: "Title",
        placeholder: "Name of category",
        value: nil,
        keyboardType: .default
    )
    
    lazy var costsLimitTextField: TextFieldPresenter = .init(
        title: "Costs limit",
        placeholder: "Period cost limit",
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
    
    var category: DTO.Category? { didSet {
        nameTextField.value = category?.name
        costsLimitTextField.value = category?.fundsLimit == nil ? nil : String(category!.fundsLimit)
        typeSegmentedControl.selectedId = category?.periodTypeInt ?? 0
        selectColorWell.selectedColor = category?.colorHEX == nil ? nil : UIColor(rgb: category!.colorHEX)
    }}
    
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
              let fundsLimit = Double(self.costsLimitTextField.value ?? "0"),
              let colorHEX = self.selectColorWell.selectedColor?.rgb()
        else { return }

        let typeSegment = self.typeSegmentedControl.segments[self.typeSegmentedControl.selectedId]
        
        var category = DTO.Category(
            date: Date(),
            name: name,
            colorHEX: colorHEX,
            spentFunds: 0,
            fundsLimit: fundsLimit,
            periodTypeInt: typeSegment.id
        )
        
        category.id = self.category?.id
        
        self.bl.category.save(model: category)
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
