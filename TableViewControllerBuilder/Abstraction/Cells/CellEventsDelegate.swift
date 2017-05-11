//
//  CellEventsDelegate.swift
//  CoMotion
//
//  Created by Corneliu on 27/04/2017.
//  Copyright © 2017 CoMotion. All rights reserved.
//

import Foundation

public protocol CellEventsDelegate {
    associatedtype CellDisplayDataType
    func didSelect(cellWith displayData: CellDisplayDataType)
}
