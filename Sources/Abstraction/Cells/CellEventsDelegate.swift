//
//  CellEventsDelegate.swift
//  Copyright © 2017 Dolfn. All rights reserved.
//

import Foundation

public protocol CellEventsDelegate {
    associatedtype CellDisplayDataType
    func didSelect(cellWith displayData: CellDisplayDataType)
}
