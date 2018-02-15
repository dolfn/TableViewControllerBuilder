//
//  TableViewOperationsManagerTests.swift
//  Copyright © 2018 Dolfn. All rights reserved.
//

import XCTest
@testable import TableViewControllerBuilder

class TableViewOperationsManagerTests: XCTestCase {

    var sut: TableViewOperationsManager<FakeHeaderDisplayData, FakeCellDisplayData>!
    var tableView: UITableViewSpy!
    
    func test_GivenReconfigurator_IsRetainedWeak() {
        var cellReconfiguratorSpy: CellReconfigurator? = CellReconfiguratorSpy()
        sut = TableViewOperationsManager<FakeHeaderDisplayData, FakeCellDisplayData>(cellReconfigurator: cellReconfiguratorSpy!)
        weak var reference: CellReconfigurator? = cellReconfiguratorSpy
        cellReconfiguratorSpy = nil
        XCTAssertNil(reference)
    }
    
    func test_GivenTableView_IsRetainedWeak() {
        let cellReconfiguratorSpy: CellReconfigurator? = CellReconfiguratorSpy()
        sut = TableViewOperationsManager<FakeHeaderDisplayData, FakeCellDisplayData>(cellReconfigurator: cellReconfiguratorSpy!)
        tableView = UITableViewSpy()
        sut.tableView = tableView
        weak var reference: UITableViewSpy? = sut.tableView as? UITableViewSpy
        tableView = nil
        XCTAssertNil(reference)
    }
    
    func test_GivenUpdatables_AreRetainedStrong() {
        let cellReconfiguratorSpy: CellReconfigurator? = CellReconfiguratorSpy()
        sut = TableViewOperationsManager<FakeHeaderDisplayData, FakeCellDisplayData>(cellReconfigurator: cellReconfiguratorSpy!)

        let rowDataUpdatable = AnyCellDisplayDataUpdatable(updatable: CellDisplayDataUpdatableSpy())
        sut.rowDataUpdatable = rowDataUpdatable

        let rowHeightsDataUpdatable = AnyCellDisplayDataUpdatable(updatable: CellDisplayDataUpdatableSpy())
        sut.rowHeightsDataUpdatable = rowHeightsDataUpdatable

        let headerDataUpdatable = AnyHeaderDisplayDataUpdatable(updatable: HeaderDisplayDataUpdatableSpy())
        sut.headerDataUpdatable = headerDataUpdatable
        
        wait(for: 0.1)
        XCTAssertNotNil(rowDataUpdatable)
        XCTAssertNotNil(rowHeightsDataUpdatable)
        XCTAssertNotNil(headerDataUpdatable)
    }
}
