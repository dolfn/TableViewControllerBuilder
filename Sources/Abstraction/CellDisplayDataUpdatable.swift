//
//  CellDisplayDataUpdatable.swift
//  Copyright © 2017 Dolfn. All rights reserved.
//

import Foundation

protocol CellDisplayDataUpdatable {
    associatedtype CellDisplayDataToUpdateWith
    func updateData(cellsDisplayData: [[CellDisplayDataToUpdateWith]])
}
