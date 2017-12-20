//
//  HelperElements.swift
//  Copyright © 2017 Dolfn. All rights reserved.
//

import Foundation
import UIKit
@testable import TableViewControllerBuilder


typealias SectionDataAlias = AnySectionDisplayData<FakeHeaderDisplayData, FakeCellDisplayData>

class FakeHeaderDisplayData: HeightFlexible {
    var height: CGFloat = 0
    var estimatedHeight: CGFloat = 0
}
class FakeCellDisplayData: HeightFlexible {
    var height: CGFloat = 0
    var estimatedHeight: CGFloat = 0
}

struct SectionDisplayDataStub: SectionDisplayData {
    typealias HeaderDisplayDataType = FakeHeaderDisplayData
    typealias CellDisplayDataType = FakeCellDisplayData
    
    var headerDisplayData: FakeHeaderDisplayData?
    var sectionRowsData: [FakeCellDisplayData]
}

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

class CellConfiguratorFactoryMock: CellConfiguratorFactory {
    typealias CellDisplayData = FakeCellDisplayData
    
    var numberOfTimesCalledToConfigureRow = 0
    
    func cellConfigurator(with cellDisplayData: FakeCellDisplayData) -> AnyClosureCellConfigurator<FakeCellDisplayData> {
        let configurator = ClosureCellConfigurator {[weak self] (cell: UITableViewCell, data: FakeCellDisplayData) in
            self?.numberOfTimesCalledToConfigureRow += 1
        }
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
