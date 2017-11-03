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
    var viewModel = TableViewModelStub()
    var navController: UINavigationController!
    
    override func setUp() {
        super.setUp()
        
        navController = UINavigationController()
        let cellConfiguratorFactory = CellConfiguratorFactoryMock()
        sut = TableViewControllerBuilder(viewModel: viewModel, cellConfiguratorFactory: cellConfiguratorFactory)
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func test_OnCreate_CanGetTableViewController() {
        XCTAssertNotNil(sut.tableViewController)
    }
    
    func test_OnCreate_DelegateExists() {
        _ = sut.tableViewController
        XCTAssertNotNil(sut.tableViewDelegate)
    }
    
    func test_IsHavingATableView() {
        XCTAssertNotNil(firstView(), "First view in Table View Controller should not be nil")
    }
    
    func test_FirstViewControllerIsTableView() {
        XCTAssertTrue(firstView() is UITableView)
    }
    
    private func firstView() -> UIView? {
        return sut.tableViewController.view.subviews.first
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
        let _ = sut.tableViewDelegate
        XCTAssertNotNil(tableView.delegate!.tableView!(tableView, viewForHeaderInSection: 0))
    }
    
    func addHeadersToTableView() {
        let headerConfiguratorFactory = HeaderConfiguratorFactoryMock()
        sut.addHeaders(with: headerConfiguratorFactory)
    }
}

extension TableViewControllerBuilderTests {
    
    class FakeHeaderDisplayData: HeightFlexible {
        var height: Int = 0
    }
    class FakeCellDisplayData: HeightFlexible {
        var height: Int = 0
    }
    
    struct TableViewModelStub: TableViewModel {
        
        struct SectionDisplayDataStub: SectionDisplayData {
            typealias HeaderDisplayDataType = FakeHeaderDisplayData
            typealias CellDisplayDataType = FakeCellDisplayData
            
            var headerDisplayData: TableViewControllerBuilderTests.FakeHeaderDisplayData
            var sectionRowsData: [TableViewControllerBuilderTests.FakeCellDisplayData]
        }
        
        typealias HeaderDisplayDataType = FakeHeaderDisplayData
        typealias CellDisplayDataType = FakeCellDisplayData
        
        var shouldBeScrollable: Bool = false
        var sectionsDisplayData: [AnySectionDisplayData<TableViewControllerBuilderTests.FakeHeaderDisplayData, TableViewControllerBuilderTests.FakeCellDisplayData>]
        
        init() {
            let headerDisplayData = FakeHeaderDisplayData()
            let section = SectionDisplayDataStub(headerDisplayData: headerDisplayData, sectionRowsData: [])
            let erasedSection = AnySectionDisplayData(sectionDisplayData: section)
            sectionsDisplayData = [erasedSection]
        }
    }
    
    class CellConfiguratorFactoryMock: CellConfiguratorFactory {
        typealias CellDisplayData = FakeCellDisplayData
        
        func cellConfigurator(with cellDisplayData: TableViewControllerBuilderTests.FakeCellDisplayData) -> AnyClosureCellConfigurator<TableViewControllerBuilderTests.FakeCellDisplayData> {
            let configurator = ClosureCellConfigurator { (cell: UITableViewCell, data: FakeCellDisplayData) in }
            return AnyClosureCellConfigurator(base:configurator)
        }
    }
    
    class HeaderConfiguratorFactoryMock: HeaderConfiguratorFactory {
        typealias HeaderDisplayDataType = FakeHeaderDisplayData
        func configurator(with displayDataType: TableViewControllerBuilderTests.FakeHeaderDisplayData) -> AnyHeaderViewConfigurator<TableViewControllerBuilderTests.FakeHeaderDisplayData>? {
            let configurator = ClosureHeaderConfigurator {(displayData: FakeHeaderDisplayData, UITableViewHeaderFooterView) in }
            return AnyHeaderViewConfigurator(baseConfigurator: configurator)
        }
    }
}
