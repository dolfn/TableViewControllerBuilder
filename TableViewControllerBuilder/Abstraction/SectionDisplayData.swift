//
//  SectionDisplayData.swift
//  TableViewControllerBuilder
//
//  Created by Corneliu on 10/04/2017.
//  Copyright © 2017 Dolfn. All rights reserved.
//

import Foundation

public protocol SectionDisplayData {
    associatedtype HeaderDisplayDataType
    associatedtype CellDisplayDataType
    var headerDisplayData: HeaderDisplayDataType { get }
    var sectionRowsData: [CellDisplayDataType] { get }
}

extension SectionDisplayData {
    var erased: AnySectionDisplayData<HeaderDisplayDataType, CellDisplayDataType> {
        get {
            return AnySectionDisplayData(sectionDisplayData: self)
        }
    }
}
