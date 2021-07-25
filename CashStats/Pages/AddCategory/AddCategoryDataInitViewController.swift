//
//  AddCategoryDataInitViewController.swift
//  CashStats
//
//  Created by GGsrvg on 25.07.2021.
//

import DTO

struct AddCategoryDataInitViewController: BaseDataInitViewController {
    /**
     If nil then create new category
     another update category
     */
    let category: DTO.Category?
}
