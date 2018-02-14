//
//  TableViewControllerBuilderTests.swift
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
    
    func test_OnCreate_GetViewController() {
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
        XCTAssertNotNil(tableView.dataSource, "Table view does not have a data source")
    }
    
    func test_TableView_HasDelegate() {
        let tableView = firstView() as! UITableView
        XCTAssertNotNil(tableView.delegate, "Table view does not have delegate")
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
        XCTAssertNotNil(tableView.delegate?.tableView?(tableView, viewForHeaderInSection: 0))
    }
    
    func test_HeaderViewExistanceConformsToViewModelHeaderExistance() {
        let tableView = firstView() as! UITableView
        
        var section = SectionDisplayDataStub(headerDisplayData: nil, sectionRowsData: [])
        viewModel.sectionsDisplayData.append(section.erased)
        
        let headerDisplayData = FakeHeaderDisplayData()
        section = SectionDisplayDataStub(headerDisplayData: headerDisplayData, sectionRowsData: [])
        viewModel.sectionsDisplayData.append(section.erased)
        
        addHeadersToTableView()
        
        XCTAssertNotNil(tableView.delegate?.tableView?(tableView, viewForHeaderInSection: 0))
        XCTAssertNil(tableView.delegate?.tableView?(tableView, viewForHeaderInSection: 1))
        XCTAssertNotNil(tableView.delegate?.tableView?(tableView, viewForHeaderInSection: 2))
    }
    
    func test_AfterCreatedATableViewController_DontCreateAnotherOne() {
        let vc = sut.buildTableViewController()
        let vc2 = sut.buildTableViewController()
        
        XCTAssertEqual(vc, vc2, "The table view builder shouldn't create another view controller, when asked for the table view controller")
    }
    
    func test_BeforeCreatingATableViewController_ShouldCreateADelegate() {
        let delegate = sut.buildTableViewModelDelegate()
        
        XCTAssertNotNil(delegate, "The table view builder shouldn't create a view model delegate, if a table view controller was not created yet")
    }
    
    func test_AfterCreatingATableViewController_ShouldBeAbleToCreateADelegate() {
        //we have to retain the view controller
        let vc = sut.buildTableViewController()
        fakeUse(vc: vc)
        let delegate = sut.buildTableViewModelDelegate()
        
        XCTAssertNotNil(delegate, "The table view builder should create a view model delegate, if a table view controller was created")
    }
    
    func test_WhenCreatingVC_ShouldHaveContentInsets() {
        let tableView = firstView() as! UITableView
        XCTAssertEqual(tableView.contentInset, viewModel.edgeInsets)
    }
    
    func test_BeforeCreatingVC_ShouldBeAbleToCreateTableViewModelDelegate() {
        let delegate = sut.buildTableViewModelDelegate()
        XCTAssertNotNil(delegate)
    }
    
    func test_AfterGettingAViewModelDelegate_ItShouldUpdateTheTableView() {
        let delegate = sut.buildTableViewModelDelegate()
        let tableView = firstView() as! UITableView
        let dataSourceSpy = TableViewDataSourceSpy(numberOfRowsInFirstSection: 2)
        tableView.dataSource = dataSourceSpy
        let indexPathToInsert = IndexPath(row: 1, section: 0)
        
        //insert row in view model's section
        var oldRows = viewModel.sectionsDisplayData[indexPathToInsert.section].sectionRowsData
        let rowDisplayData = FakeCellDisplayData()
        oldRows.insert(rowDisplayData, at: indexPathToInsert.row)
        let newSection = SectionDisplayDataStub(headerDisplayData: nil, sectionRowsData: oldRows)
        viewModel.sectionsDisplayData[indexPathToInsert.section] = newSection.erased
        
        delegate?.didInsert(itemsAt: [indexPathToInsert], in: viewModel.erased, animated: false)
        XCTAssertTrue(dataSourceSpy.didTryToConfigureCell)
    }
    
    func test_AfterAddingCellEventsHandler_ItShouldCallHandler() {
        let cellEventsHandler = CellEventsHandlerSpy()
        sut.addEventsHandler(handler: cellEventsHandler)
        let tableView = firstView() as! UITableView
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.delegate?.tableView?(tableView, didSelectRowAt: indexPath)
        XCTAssertTrue(cellEventsHandler.didSelectCell)
    }
    
    func test_ToSetBackgroundColorFromViewModel() {
        let viewController = sut.buildTableViewController()
        XCTAssertEqual(viewController.view.backgroundColor, viewModel.backgroundColor)
    }
    
    func test_ToSetScrollValueFromViewModel() {
        let tableView = firstView() as? UITableView
        XCTAssertEqual(tableView?.isScrollEnabled, viewModel.shouldBeScrollable)
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
