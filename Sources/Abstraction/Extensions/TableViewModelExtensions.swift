//
//  TableViewModelExtensions.swift
//  Copyright © 2018 Dolfn. All rights reserved.
//

import Foundation

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
