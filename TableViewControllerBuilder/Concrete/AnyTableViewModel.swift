//
//  AnyTableViewModel.swift
//  TableViewControllerBuilder
//
//  Created by Corneliu on 13/04/2017.
//  Copyright © 2017 Dolfn. All rights reserved.
//

import Foundation

struct AnyTableViewModel<H, R>: TableViewModel {
    typealias HeaderDisplayDataType = H
    typealias RowDisplayDataType = R
    
    var sectionsDisplayData: [AnySectionDisplayData<H, R>] {
        get {
            return _sectionsDisplayData
        }
    }
    
    let _sectionsDisplayData: [AnySectionDisplayData<H, R>]
    
    init<TableViewModelType: TableViewModel>(tableViewModel: TableViewModelType) where TableViewModelType.HeaderDisplayDataType == H, TableViewModelType.CellDisplayDataType == R {
        _sectionsDisplayData = tableViewModel.sectionsDisplayData
    }
}
