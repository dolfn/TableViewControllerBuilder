//
//  SectionDisplayData.swift
//  TableViewControllerBuilder
//
//  Created by Corneliu on 10/04/2017.
//  Copyright © 2017 Corneliu. All rights reserved.
//

import Foundation

public protocol SectionDisplayData {
    associatedtype HeaderDisplayDataType
    associatedtype CellDisplayDataType
    var headerDisplayData: HeaderDisplayDataType { get }
    var sectionRowsData: [CellDisplayDataType] { get }
}
