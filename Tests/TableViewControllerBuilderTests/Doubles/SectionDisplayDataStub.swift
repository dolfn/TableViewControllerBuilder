//
//  SectionDisplayDataStub.swift
//  Copyright © 2018 Dolfn. All rights reserved.
//

import Foundation

struct SectionDisplayDataStub: SectionDisplayData {
    
    typealias HeaderDisplayDataType = FakeHeaderDisplayData
    typealias CellDisplayDataType = FakeCellDisplayData
    
    var headerDisplayData: FakeHeaderDisplayData?
    var sectionRowsData: [FakeCellDisplayData]
    
}
