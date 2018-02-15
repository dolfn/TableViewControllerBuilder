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
}
