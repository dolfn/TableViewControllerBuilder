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
    var existingViewModelSection: SectionDataAlias!
    var viewModel: TableViewModelStub!
    var sut: AnyTableViewModelDelegate<FakeHeaderDisplayData, FakeCellDisplayData>!
    var vc: UIViewController!
    var tableView: UITableView!
    
    override func setUp() {
        super.setUp()
        viewModel = TableViewModelStub()
        existingViewModelSection = viewModel.sectionsDisplayData[0]
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
        let initialNumberOfSections = tableView.dataSource?.numberOfSections?(in: tableView)
        
        sut.didUpdateSection(at: 0, in: viewModel.erased)
        
        let numberOfSectionsAfterUpdate = tableView.dataSource?.numberOfSections?(in: tableView)
        XCTAssertEqual(initialNumberOfSections, numberOfSectionsAfterUpdate)
    }
    
    func test_WhenAddingModifyingASection_ItShouldReflectTheChanges() {
        assertNewHeaderAndRowHeights(in: 0, with: {[weak self] in
            self?.sut.didUpdateSection(at: 0, in: viewModel.erased)
        })
    }
    
    func test_UpdatingHeightsInTableView() {
        assertNewHeaderAndRowHeights(in: 0, with: {[weak self] in
            self?.sut.didUpdateHeights(in: viewModel.erased)
        })
    }
    
    func assertNewHeaderAndRowHeights(in sectionIndex: Int, with delegateCall: () -> Void, lineNumber: UInt = #line) {
        let updatedRowHeight = 10
        let updatedHeaderHeight = 5
        
        existingViewModelSection.headerDisplayData.height = updatedHeaderHeight
        existingViewModelSection.sectionRowsData[0].height = updatedRowHeight
        viewModel.sectionsDisplayData[0] = existingViewModelSection
        delegateCall()
        addHeadersToTableView()
        
        let headerHeightAfterUpdate = tableView.delegate?.tableView?(tableView, heightForHeaderInSection: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        let rowHeightAfterUpdate = tableView.delegate?.tableView?(tableView, heightForRowAt: indexPath)
        
        XCTAssertEqual(headerHeightAfterUpdate, CGFloat(updatedHeaderHeight), line: lineNumber)
        XCTAssertEqual(rowHeightAfterUpdate, CGFloat(updatedRowHeight), line: lineNumber)
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
