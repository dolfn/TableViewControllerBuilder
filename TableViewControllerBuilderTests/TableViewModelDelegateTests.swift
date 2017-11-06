//
//  TableViewModelDelegateTests.swift
//  TableViewControllerBuilderTests
//
//  Created by Corneliu on 06/11/2017.
//  Copyright © 2017 Dolfn. All rights reserved.
//

import XCTest
@testable import TableViewControllerBuilder

class TableViewModelDelegateTests: XCTestCase {
    
    var tableViewBuilder: TableViewControllerBuilder<FakeHeaderDisplayData, FakeCellDisplayData>!
    var viewModel: TableViewModelStub!
    var sut: AnyTableViewModelDelegate<FakeHeaderDisplayData, FakeCellDisplayData>!
    var vc: UIViewController!
    
    override func setUp() {
        super.setUp()
        viewModel = TableViewModelStub()
        let cellConfiguratorFactory = CellConfiguratorFactoryMock()
        tableViewBuilder = TableViewControllerBuilder(viewModel: viewModel, cellConfiguratorFactory: cellConfiguratorFactory)
        vc = tableViewBuilder.tableViewController
        sut = tableViewBuilder.tableViewDelegate
    }
    
    override func tearDown() {
        tableViewBuilder = nil
        viewModel = nil
        sut = nil
        vc = nil
        super.tearDown()
    }
    
    func test_TableView_HasTwoSections() {
        let newSection = getNewSection()
        assertNumberOfSectionsInTableView(sectionsToAdd: [newSection])
    }
    
    func test_TableView_HasThreeSections() {
        let newSection = getNewSection()
        assertNumberOfSectionsInTableView(sectionsToAdd: [newSection, newSection])
    }
    
    func test_TableView_HasFiveSections() {
        let newSection = getNewSection()
        assertNumberOfSectionsInTableView(sectionsToAdd: [newSection, newSection, newSection, newSection])
    }
    
    func assertNumberOfSectionsInTableView(sectionsToAdd: [SectionDataAlias], testFailAt lineNumber: UInt = #line) {
        let expectedNumberOfSections = sectionsToAdd.count + 1
        
        let tableView = vc.view.subviews.first as! UITableView
        viewModel.sectionsDisplayData.append(contentsOf: sectionsToAdd)
        
        var startingIndex: Int = 0
        let indexesInserted = sectionsToAdd.map { _ -> Int in
            startingIndex += 1;
            return startingIndex
        }
        sut.didInsertSections(at: indexesInserted, in: viewModel.erased)
        
        let assertMessage = "The number of sections is not " + String(expectedNumberOfSections)
        XCTAssertEqual(tableView.numberOfSections, expectedNumberOfSections, assertMessage, line: lineNumber)
    }
    
    func getNewSection() -> SectionDataAlias {
        let newHeader = FakeHeaderDisplayData()
        let section = SectionDisplayDataStub(headerDisplayData: newHeader, sectionRowsData: [])
        return section.erased
    }
}
