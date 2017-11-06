//
//  TableViewEventHandler.swift
//  TableViewControllerBuilder
//
//  Created by Corneliu on 18/04/2017.
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
