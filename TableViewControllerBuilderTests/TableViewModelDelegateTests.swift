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
    var tableView: UITableView!
    
    override func setUp() {
        super.setUp()
        viewModel = TableViewModelStub()
        let cellConfiguratorFactory = CellConfiguratorFactoryMock()
        tableViewBuilder = TableViewControllerBuilder(viewModel: viewModel, cellConfiguratorFactory: cellConfiguratorFactory)
        vc = tableViewBuilder.buildTableViewController()
        sut = tableViewBuilder.buildTableViewModelDelegate()
        tableView = vc.view.subviews.first as! UITableView
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
    
    func test_WhenInsertingNewSectionWithHeader_HeadersHaveTheSpecifiedHeight() {
        let newSection = getNewSection(headerHeight: 5)
        viewModel.sectionsDisplayData.append(newSection)
        addHeadersToTableView()
        sut.didInsertSections(at: [1], in: viewModel.erased)
        guard let heightOfTheHeader = tableView.delegate?.tableView?(tableView, heightForHeaderInSection: 1) else {
            XCTFail("Should be able to return height of the header");
            return
        }
        XCTAssertEqual(heightOfTheHeader, 5)
    }
    
    func test_AddingHeadersAfterInsertingNewSection_ShouldDisplayTheCorrectNumberOfSections() {
        let newSection = getNewSection(headerHeight: 5)
        viewModel.sectionsDisplayData.append(newSection)
        sut.didInsertSections(at: [1], in: viewModel.erased)
        addHeadersToTableView()
        XCTAssertNotNil(tableView.delegate?.tableView?(tableView, viewForHeaderInSection: 1))
    }
    
    func test_WhenAddingModifyingASection_ItShouldHaveTheSameNumberOfSections() {
        let existingSection = viewModel.sectionsDisplayData[0]
        let initialNumberOfSections = tableView.dataSource?.numberOfSections?(in: tableView)
        
        sut.didUpdateSection(at: 0, in: viewModel.erased)
        
        let numberOfSectionsAfterUpdate = tableView.dataSource?.numberOfSections?(in: tableView)
        XCTAssertEqual(initialNumberOfSections, numberOfSectionsAfterUpdate)
    }
    
    func test_WhenAddingModifyingASection_ItShouldReflectTheChanges() {
        var existingSection = viewModel.sectionsDisplayData[0]
        let initialNumberOfSections = tableView.dataSource?.numberOfSections?(in: tableView)
        let updatedRowHeight = 10
        let updatedHeaderHeight = 5
        
        addHeadersToTableView()
        existingSection.headerDisplayData.height = updatedHeaderHeight
        existingSection.sectionRowsData[0].height = updatedRowHeight
        viewModel.sectionsDisplayData[0] = existingSection
        sut.didUpdateSection(at: 0, in: viewModel.erased)
        
        let headerHeightAfterUpdate = tableView.delegate?.tableView?(tableView, heightForHeaderInSection: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        let rowHeightAfterUpdate = tableView.delegate?.tableView?(tableView, heightForRowAt: indexPath)
        
        XCTAssertEqual(headerHeightAfterUpdate, CGFloat(updatedHeaderHeight))
        XCTAssertEqual(rowHeightAfterUpdate, CGFloat(updatedRowHeight))
    }
    
    func assertNumberOfSectionsInTableView(sectionsToAdd: [SectionDataAlias], testFailAt lineNumber: UInt = #line) {
        let expectedNumberOfSections = sectionsToAdd.count + 1
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
    
    func getNewSection(headerHeight: Int = 0) -> SectionDataAlias {
        let newHeader = FakeHeaderDisplayData()
        newHeader.height = headerHeight
        let row = FakeCellDisplayData()
        let section = SectionDisplayDataStub(headerDisplayData: newHeader, sectionRowsData: [row])
        return section.erased
    }
    
    func addHeadersToTableView() {
        let headerConfiguratorFactory = HeaderConfiguratorFactoryMock()
        tableViewBuilder.addHeaders(with: headerConfiguratorFactory, from: viewModel)
    }
}
