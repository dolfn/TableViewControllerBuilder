//
//  HelperElements.swift
//  TableViewControllerBuilderTests
//
//  Created by Corneliu on 06/11/2017.
//  Copyright © 2017 Dolfn. All rights reserved.
//

import Foundation
import UIKit
@testable import TableViewControllerBuilder


typealias SectionDataAlias = AnySectionDisplayData<FakeHeaderDisplayData, FakeCellDisplayData>

class FakeHeaderDisplayData: HeightFlexible {
    var height: Int = 0
}
class FakeCellDisplayData: HeightFlexible {
    var height: Int = 0
}

struct SectionDisplayDataStub: SectionDisplayData {
    typealias HeaderDisplayDataType = FakeHeaderDisplayData
    typealias CellDisplayDataType = FakeCellDisplayData
    
    var headerDisplayData: FakeHeaderDisplayData
    var sectionRowsData: [FakeCellDisplayData]
}

struct TableViewModelStub: TableViewModel {
    
    typealias HeaderDisplayDataType = FakeHeaderDisplayData
    typealias CellDisplayDataType = FakeCellDisplayData
    
    var shouldBeScrollable: Bool = false
    var sectionsDisplayData: [SectionDataAlias]
    
    init() {
        let headerDisplayData = FakeHeaderDisplayData()
        let rowDisplayData = FakeCellDisplayData()
        let section = SectionDisplayDataStub(headerDisplayData: headerDisplayData, sectionRowsData: [rowDisplayData])
        sectionsDisplayData = [section.erased]
    }
}

class CellConfiguratorFactoryMock: CellConfiguratorFactory {
    typealias CellDisplayData = FakeCellDisplayData
    
    func cellConfigurator(with cellDisplayData: FakeCellDisplayData) -> AnyClosureCellConfigurator<FakeCellDisplayData> {
        let configurator = ClosureCellConfigurator { (cell: UITableViewCell, data: FakeCellDisplayData) in }
        return AnyClosureCellConfigurator(base:configurator)
    }
}

class HeaderConfiguratorFactoryMock: HeaderConfiguratorFactory {
    typealias HeaderDisplayDataType = FakeHeaderDisplayData
    func configurator(with displayDataType: FakeHeaderDisplayData) -> AnyHeaderViewConfigurator<FakeHeaderDisplayData>? {
        let configurator = ClosureHeaderConfigurator {(displayData: FakeHeaderDisplayData, UITableViewHeaderFooterView) in }
        return AnyHeaderViewConfigurator(baseConfigurator: configurator)
    }
}
