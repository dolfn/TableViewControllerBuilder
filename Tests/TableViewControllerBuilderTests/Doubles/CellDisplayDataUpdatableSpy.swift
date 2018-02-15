//
//  CellDisplayDataUpdatableSpy.swift
//  Copyright © 2018 Dolfn. All rights reserved.
//

import Foundation

class CellDisplayDataUpdatableSpy: CellDisplayDataUpdatable {
    
    typealias CellDisplayDataToUpdateWith = FakeCellDisplayData
    
    var cellsDisplayData = [[FakeCellDisplayData]]()
    
    func updateData(cellsDisplayData: [[FakeCellDisplayData]]) {
        self.cellsDisplayData = cellsDisplayData
    }
}
