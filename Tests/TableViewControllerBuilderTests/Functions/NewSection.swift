//
//  NewSection.swift
//  Copyright © 2018 Dolfn. All rights reserved.
//

import Foundation
import UIKit

func getNewSection(headerHeight: CGFloat = 0, numberOfRows: UInt = 1, rowHeight: CGFloat = 0, estimatedRowHeight: CGFloat = 0) -> SectionDataAlias {
    var newHeader = FakeHeaderDisplayData()
    newHeader.height = headerHeight
    var rows = [FakeCellDisplayData]()
    (0..<numberOfRows).forEach { (_) in
        var row = FakeCellDisplayData()
        row.height = rowHeight
        row.estimatedHeight = estimatedRowHeight
        rows.append(row)
    }
    let section = SectionDisplayDataStub(headerDisplayData: newHeader, sectionRowsData: rows)
    return section.erased
}
