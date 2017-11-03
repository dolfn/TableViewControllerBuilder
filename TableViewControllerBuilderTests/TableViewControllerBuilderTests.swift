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
    
    var sut: TableViewControllerBuilder<HeaderDisplayDataMock, CellDisplayDataMock>!
    
    override func setUp() {
        super.setUp()
        let viewModel = TableViewModelMock()
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
    
}

extension TableViewControllerBuilderTests {
    
    class HeaderDisplayDataMock: HeightFlexible {
        var height: Int = 0
    }
    class CellDisplayDataMock: HeightFlexible {
        var height: Int = 0
    }
    
    class TableViewModelMock: TableViewModel {
        
        typealias HeaderDisplayDataType = HeaderDisplayDataMock
        typealias CellDisplayDataType = CellDisplayDataMock
        
        var sectionsDisplayData = [AnySectionDisplayData<TableViewControllerBuilderTests.HeaderDisplayDataMock, TableViewControllerBuilderTests.CellDisplayDataMock>]()
        
        var shouldBeScrollable: Bool = false
    }
    
    class CellConfiguratorFactoryMock: CellConfiguratorFactory {
        typealias CellDisplayData = CellDisplayDataMock
        
        func cellConfigurator(with cellDisplayData: TableViewControllerBuilderTests.CellDisplayDataMock) -> AnyClosureCellConfigurator<TableViewControllerBuilderTests.CellDisplayDataMock> {
            let configurator = ClosureCellConfigurator { (cell: UITableViewCell, data: CellDisplayDataMock) in }
            return AnyClosureCellConfigurator(base:configurator)
        }
    }
}
