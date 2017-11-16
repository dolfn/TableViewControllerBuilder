//
//  TableViewModel.swift
//  TableViewControllerBuilder
//
//  Created by Corneliu on 13/04/2017.
//  Copyright © 2017 Dolfn. All rights reserved.
//

import Foundation

public protocol TableViewModel {
    associatedtype HeaderDisplayDataType
    associatedtype CellDisplayDataType
    
    typealias SectionDisplayDataType = AnySectionDisplayData<HeaderDisplayDataType, CellDisplayDataType>
    var shouldBeScrollable: Bool { get }
    var sectionsDisplayData: [SectionDisplayDataType] { get }
}

extension TableViewModel {
    var justCellData: [[CellDisplayDataType]] {
        let justTheRowsInSections = self.sectionsDisplayData.map { (sectionDisplayData) -> [CellDisplayDataType] in
            return sectionDisplayData.sectionRowsData
        }
        
        return justTheRowsInSections
    }
    
    var justHeaderData: [HeaderDisplayDataType?] {
        let justTheHeadersInSections = self.sectionsDisplayData.map { (sectionDisplayData) -> HeaderDisplayDataType? in
            return sectionDisplayData.headerDisplayData
        }
        
        return justTheHeadersInSections
    }
    
    public var erased: AnyTableViewModel<HeaderDisplayDataType, CellDisplayDataType> {
        get {
            return AnyTableViewModel<HeaderDisplayDataType, CellDisplayDataType>(tableViewModel: self)
        }
    }
}
