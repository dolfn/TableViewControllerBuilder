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
        let vc = sut.buildTableViewController()
        fakeUse(vc: vc)
        XCTAssertNotNil(sut.buildTableViewModelDelegate())
    }
    
    func test_IsHavingATableView() {
        XCTAssertNotNil(firstView(), "First view in Table View Controller should not be nil")
    }
    
    func test_FirstViewControllerIsTableView() {
        XCTAssertTrue(firstView() is UITableView)
    }
    
    func test_TableView_HasDataSource() {
        let tableView = firstView() as! UITableView
        XCTAssertNotNil(tableView.dataSource, "table view does not have a data source")
    }
    
    func test_TableView_HasDelegate() {
        let tableView = firstView() as! UITableView
        XCTAssertNotNil(tableView.delegate, "Table view should not have delegate")
    }
    
    func test_WhenAddingHeaderConfigurator_ShouldHaveTheSameNumberOfSections() {
        let tableView = firstView() as! UITableView
        addHeadersToTableView()
        guard let numberOfSections = tableView.dataSource?.numberOfSections?(in: tableView) else {
            XCTFail("table view does not have a data source")
            return
        }
        XCTAssertEqual(numberOfSections, 1)
    }
    
    func test_HeaderViewForFirstSectionExists() {
        let tableView = firstView() as! UITableView
        addHeadersToTableView()
        XCTAssertNotNil(tableView.delegate!.tableView!(tableView, viewForHeaderInSection: 0))
    }
    
    func test_HeaderViewExistanceConformsToViewModelHeaderExistance() {
        let tableView = firstView() as! UITableView
        
        var section = SectionDisplayDataStub(headerDisplayData: nil, sectionRowsData: [])
        viewModel.sectionsDisplayData.append(section.erased)
        
        let headerDisplayData = FakeHeaderDisplayData()
        section = SectionDisplayDataStub(headerDisplayData: headerDisplayData, sectionRowsData: [])
        viewModel.sectionsDisplayData.append(section.erased)
        
        addHeadersToTableView()
        
        XCTAssertNotNil(tableView.delegate!.tableView!(tableView, viewForHeaderInSection: 0))
        XCTAssertNil(tableView.delegate!.tableView!(tableView, viewForHeaderInSection: 1))
        XCTAssertNotNil(tableView.delegate!.tableView!(tableView, viewForHeaderInSection: 2))
    }
    
    func test_AfterCreatedATableViewController_DontCreateAnotherOne() {
        let vc = sut.buildTableViewController()
        let vc2 = sut.buildTableViewController()
        
        XCTAssertEqual(vc, vc2, "The table view builder shouldn't create another view controller, when asked for the table view controller")
    }
    
    func test_AfterDestroyingOldVC_CreateAnotherOne() {
        var vc: UIViewController? = sut.buildTableViewController()
        let address = vc!.description
        vc = nil
        vc = sut.buildTableViewController()
        let address2 = vc!.description
        
        XCTAssertNotEqual(address, address2, "The table view builder should create another view controller, when the old one is destroyed")
    }
    
    func test_BeforeCreatingATableViewController_CantCreateADelegate() {
        let delegate = sut.buildTableViewModelDelegate()
        
        XCTAssertNil(delegate, "The table view builder shouldn't create a view model delegate, if a table view controller was not created yet")
    }
    
    func test_AfterCreatingATableViewController_ShouldBeAbleToCreateADelegate() {
        //we have to retain the view controller
        let vc = sut.buildTableViewController()
        fakeUse(vc: vc)
        let delegate = sut.buildTableViewModelDelegate()
        
        XCTAssertNotNil(delegate, "The table view builder should create a view model delegate, if a table view controller was created")
    }
    
    func test_AfterDistroyingVC_DelegateShouldNotBeCreated() {
        var vc: UIViewController? = sut.buildTableViewController()
        fakeUse(vc: vc)
        var delegate = sut.buildTableViewModelDelegate()
        vc = nil
        delegate = sut.buildTableViewModelDelegate()
        XCTAssertNil(delegate)
    }
    
    private func addHeadersToTableView() {
        let headerConfiguratorFactory = HeaderConfiguratorFactoryMock()
        sut.addHeaders(with: headerConfiguratorFactory, from: viewModel)
    }
    
    private func firstView() -> UIView? {
        return sut.buildTableViewController().view.subviews.first
    }
    
    private func fakeUse(vc: Any?) {}
}
