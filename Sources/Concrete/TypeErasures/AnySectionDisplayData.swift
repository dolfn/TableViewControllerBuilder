//
//  AnySectionDisplayData.swift
//  TableViewControllerBuilder
//
//  Created by Corneliu on 13/04/2017.
//  Copyright © 2017 Dolfn. All rights reserved.
//

import Foundation

public struct AnySectionDisplayData<H, R>: SectionDisplayData {
    
    public typealias HeaderDisplayDataType = H
    public typealias CellDisplayDataType = R
    
    public var headerDisplayData: H? {
        get {
            return _headerDisplayData
        }
    }
    
    public var sectionRowsData: [R] {
        get {
            return _sectionRowsData
        }
    }
    
    private var _headerDisplayData: H?
    private var _sectionRowsData: [R]
    
    public init<SectionDisplayDataType: SectionDisplayData>(sectionDisplayData: SectionDisplayDataType) where SectionDisplayDataType.HeaderDisplayDataType == H, SectionDisplayDataType.CellDisplayDataType == R {
        _headerDisplayData = sectionDisplayData.headerDisplayData
        _sectionRowsData = sectionDisplayData.sectionRowsData
    }
}
