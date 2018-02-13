//
//  CellConfiguratorSelectorTests.swift
//  TableViewControllerBuilder-iOS Tests
//
//  Created by Andrei Nastasiu on 09/02/2018.
//  Copyright © 2018 Dolfn. All rights reserved.
//

import XCTest
@testable import TableViewControllerBuilder

class CellConfiguratorSelectorTests: XCTestCase {
    
    var cellConfiguratorFactory: CellConfiguratorFactoryMock!
    var sut: CellConfiguratorSelector<FakeCellDisplayData>!
    var tableView: UITableView!
    
    override func setUp() {
        super.setUp()
        cellConfiguratorFactory = CellConfiguratorFactoryMock()
        sut = CellConfiguratorSelector(configuratorFactory: cellConfiguratorFactory)
        tableView = UITableView()
    }
    
    override func tearDown() {
        cellConfiguratorFactory = nil
        sut = nil
        tableView = nil
        super.tearDown()
    }
    
    func test_CallingRegister_DoesNotChangeTableViewState() {
        sut.register(in: tableView)
        XCTAssertNil(tableView.dequeueReusableCell(withIdentifier: "FakeCellDisplayData"))
    }
    
    func test_CallingConfigureCell_CreatesNeededConfigurator() {
        _ = sut.configuredCell(in: tableView, at: IndexPath(row: 0, section: 0), with: FakeCellDisplayData())
        XCTAssertEqual(cellConfiguratorFactory.configurator?.reuseIdentifier, "UITableViewCell")
        XCTAssertEqual(cellConfiguratorFactory.numberOfTimesCalledToConfigureRow, 1)
    }
    
}
