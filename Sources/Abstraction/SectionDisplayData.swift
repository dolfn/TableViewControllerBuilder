//
//  SectionDisplayData.swift
//  Copyright © 2017 Dolfn. All rights reserved.
//

import Foundation

public protocol SectionDisplayData {
    associatedtype HeaderDisplayDataType
    associatedtype CellDisplayDataType
    
    var headerDisplayData: HeaderDisplayDataType? { get }
    var sectionRowsData: [CellDisplayDataType] { get }
}
