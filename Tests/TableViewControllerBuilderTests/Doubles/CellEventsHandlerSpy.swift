//
//  CellEventsHandlerSpy.swift
//  Copyright © 2018 Dolfn. All rights reserved.
//

import Foundation

class CellEventsHandlerSpy: CellEventsDelegate {
    
    typealias CellDisplayDataType = FakeCellDisplayData
    
    var didSelectCell = false
    var willDisplayCell = false
    
    func didSelect(cellWith displayData: FakeCellDisplayData) {
        didSelectCell = true
    }
    
    func willDisplay(cellWith displayData: FakeCellDisplayData) {
        willDisplayCell = true
    }
    
}
