//
//  TableViewControllerBuilderTests.swift
//  TableViewControllerBuilderTests
//
//  Created by Corneliu on 14/04/2017.
//  Copyright © 2017 Dolfn. All rights reserved.
//

import XCTest
@testable import TableViewControllerBuilder

class TableViewControllerBuilderTests: XCTestCase {
    
    var sut: TableViewControllerBuilder<FakeHeaderDisplayData, FakeCellDisplayData>!
    var viewModel: TableViewModelStub!
    
    override func setUp() {
        super.setUp()
        
        let cellConfiguratorFactory = CellConfiguratorFactoryMock()
        viewModel = TableViewModelStub()
        sut = TableViewControllerBuilder(viewModel: viewModel, cellConfiguratorFactory: cellConfiguratorFactory)
    }
    
    override func tearDown() {
        sut = nil
        viewModel = nil
        super.tearDown()
    }
    
    func test_OnCreate_CanGetTableViewController() {
        XCTAssertNotNil(sut.buildTableViewController())
    }
    
    func test_OnCreate_DelegateExists() {
        _ = sut.buildTableViewController()
        XCTAssertNotNil(sut.buildTableViewModelDelegate())
    }
    
    func test_IsHavingATableView() {
        XCTAssertNotNil(firstView(), "First view in Table View Controller should not be nil")
    }
    
    func test_FirstViewControllerIsTableView() {
        XCTAssertTrue(firstView() is UITableView)
    }
    
    private func firstView() -> UIView? {
        return sut.buildTableViewController().view.subviews.first
    }
    
    func test_TableView_HasDataSource() {
        let tableView = firstView() as! UITableView
        XCTAssertNotNil(tableView.dataSource, "table view does not have a data source")
    }
    
    func test_TableView_HasDelegate() {
        let tableView = firstView() as! UITableView
        XCTAssertNotNil(tableView.delegate, "Table view should not have delegate")
    }
    
    func test_WhenAddingHeaderConfigurator_ShouldAddHeadersToTableView() {
        let tableView = firstView() as! UITableView
        addHeadersToTableView()
        guard let numberOfSections = tableView.dataSource?.numberOfSections?(in: tableView) else {
            XCTFail("table view does not have a data source")
            return
        }
        XCTAssertEqual(numberOfSections, 1)
    }
    
    func test_ExistingHeaderViewForFirstSection() {
        let tableView = firstView() as! UITableView
        addHeadersToTableView()
        let _ = sut.buildTableViewModelDelegate()
        XCTAssertNotNil(tableView.delegate!.tableView!(tableView, viewForHeaderInSection: 0))
    }
    
    func addHeadersToTableView() {
        let headerConfiguratorFactory = HeaderConfiguratorFactoryMock()
        sut.addHeaders(with: headerConfiguratorFactory)
    }
    
    func test_AfterCreatedATableViewController_DontCreateAnotherOne() {
        let vc = sut.buildTableViewController()
        let vc2 = sut.buildTableViewController()
        
        XCTAssertEqual(vc, vc2, "The table view builder shouldn't create another view controller, when asked for the table view controller")
    }
    
    func test_BeforeCreatingATableViewController_CantCreateADelegate() {
        let delegate = sut.buildTableViewModelDelegate()
        
        XCTAssertNil(delegate, "The table view builder shouldn't create a view model delegate, if a table view controller was not created yet")
    }
    
    func test_AfterCreatingATableViewController_ShouldBeAbleToCreateADelegate() {
        _ = sut.buildTableViewController()
        let delegate = sut.buildTableViewModelDelegate()
        
        XCTAssertNotNil(delegate, "The table view builder should create a view model delegate, if a table view controller was created")
    }
}
