//
//  TableViewEventHandler.swift
//  Copyright © 2017 Dolfn. All rights reserved.
//

import Foundation

public enum TableViewEvent {
    case SelectTableViewCell
}

public protocol TableViewEventHandler {
    associatedtype CellDisplayDataType
    
    func handle(event: TableViewEvent, forRowWith displayData: CellDisplayDataType)
}
