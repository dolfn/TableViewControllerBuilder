//
//  TableViewModelStub.swift
//  Copyright © 2018 Dolfn. All rights reserved.
//

import Foundation
import UIKit

typealias SectionDataAlias = AnySectionDisplayData<FakeHeaderDisplayData, FakeCellDisplayData>

struct TableViewModelStub: TableViewModel {
    
    typealias HeaderDisplayDataType = FakeHeaderDisplayData
    typealias CellDisplayDataType = FakeCellDisplayData
    
    var shouldBeScrollable: Bool = false
    var sectionsDisplayData: [SectionDataAlias]
    var edgeInsets: UIEdgeInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    var backgroundColor: UIColor? = UIColor.red
    
    init() {
        let headerDisplayData = FakeHeaderDisplayData()
        let rowDisplayData = FakeCellDisplayData()
        let section = SectionDisplayDataStub(headerDisplayData: headerDisplayData, sectionRowsData: [rowDisplayData])
        sectionsDisplayData = [section.erased]
    }
}
