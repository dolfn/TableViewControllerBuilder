//
//  AnyCellEventsDelegate.swift
//  Copyright © 2017 Dolfn. All rights reserved.
//

import Foundation

struct AnyCellEventsDelegate<DisplayDataType>: CellEventsDelegate {
    
    typealias CellDisplayDataType = DisplayDataType
    
    var didSelect: (DisplayDataType) -> Void
    
    init<DelegateType: CellEventsDelegate>(delegate: DelegateType) where DelegateType.CellDisplayDataType == DisplayDataType {
        self.didSelect = delegate.didSelect
    }
    
    func didSelect(cellWith displayData: DisplayDataType) {
        didSelect(displayData)
    }
}
