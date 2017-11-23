//
//  ExampleEventHandler.swift
//  TableViewControllerBuilderExample
//
//  Created by Corneliu on 18/04/2017.
//  Copyright © 2017 Corneliu. All rights reserved.
//

import Foundation
import TableViewControllerBuilder

struct ExampleEventHandler: TableViewEventHandler {
    typealias CellDisplayDataType = ExampleCellDisplayDataType
    
    func handle(event: TableViewEvent, forRowWith displayData: ExampleCellDisplayDataType) {
        
    }
}
