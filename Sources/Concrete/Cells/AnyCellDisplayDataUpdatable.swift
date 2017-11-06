//
//  AnyCellDisplayDataUpdatable.swift
//  CoMotion
//
//  Created by Corneliu on 25/04/2017.
//  Copyright © 2017 CoMotion. All rights reserved.
//

import Foundation

struct AnyCellDisplayDataUpdatable<C: HeightFlexible>: CellDisplayDataUpdatable {
    typealias CellDisplayDataToUpdateWith = C
    
    private var update: ([[C]]) -> Void
    
    init<U: CellDisplayDataUpdatable>(updatable: U) where U.CellDisplayDataToUpdateWith == C {
        update = updatable.updateData
    }
    
    func updateData(cellsDisplayData: [[C]]) {
        update(cellsDisplayData)
    }
}
