//
//  CellConfiguratorSelectorTests.swift
//  Copyright © 2018 Dolfn. All rights reserved.
//

import XCTest
@testable import TableViewControllerBuilder

class CellConfiguratorSelectorTests: XCTestCase {
    
    var cellConfiguratorFactory: CellConfiguratorFactoryMock!
    var sut: CellConfiguratorSelector<FakeCellDisplayData>!
    var tableView: UITableView!
    var indexPath: IndexPath!
    
    override func setUp() {
        super.setUp()
        cellConfiguratorFactory = CellConfiguratorFactoryMock()
        sut = CellConfiguratorSelector(configuratorFactory: cellConfiguratorFactory)
        tableView = UITableView()
        indexPath = IndexPath(row: 0, section: 0)
    }
    
    override func tearDown() {
        cellConfiguratorFactory = nil
        sut = nil
        tableView = nil
        indexPath = nil
        super.tearDown()
    }
    
    func test_CallingRegister_DoesNotChangeTableViewState() {
        sut.register(in: tableView)
        XCTAssertNil(tableView.dequeueReusableCell(withIdentifier: "FakeCellDisplayData"))
    }
    
    func test_CallingToConfigureCell_CreatesNeededConfigurator() {
        XCTAssertNil(cellConfiguratorFactory.configurator)
        _ = sut.configuredCell(in: tableView, at: indexPath, with: FakeCellDisplayData())
        XCTAssertEqual(cellConfiguratorFactory.configurator?.reuseIdentifier, "UITableViewCell")
        XCTAssertEqual(cellConfiguratorFactory.numberOfTimesCalledToConfigureRow, 1)
    }
    
    func test_CallingToReconfigureCell_CreatesNeededConfigurator() {
        XCTAssertNil(cellConfiguratorFactory.configurator)
        _ = sut.reconfigureCell(in: tableView, at: indexPath, with: FakeCellDisplayData())
        XCTAssertEqual(cellConfiguratorFactory.configurator?.reuseIdentifier, "UITableViewCell")
    }
    
}
