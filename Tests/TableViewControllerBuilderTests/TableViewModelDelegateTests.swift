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
    var cellConfiguratorFactory: CellConfiguratorFactoryMock!
    
    override func setUp() {
        super.setUp()
        viewModel = TableViewModelStub()
        existingViewModelSection = viewModel.sectionsDisplayData[0]
        cellConfiguratorFactory = CellConfiguratorFactoryMock()
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
        sut.didInsertSections(at: [1], in: viewModel.erased, animated: false)
        guard let heightOfTheHeader = tableView.delegate?.tableView?(tableView, heightForHeaderInSection: 1) else {
            XCTFail("Should be able to return height of the header");
            return
        }
        XCTAssertEqual(heightOfTheHeader, 5)
    }
    
    func test_AddingHeadersAfterInsertingNewSection_ShouldDisplayTheCorrectNumberOfSections() {
        let newSection = getNewSection(headerHeight: 5)
        viewModel.sectionsDisplayData.append(newSection)
        sut.didInsertSections(at: [1], in: viewModel.erased, animated: false)
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
    
    func test_LoadingInitialDataWithCorrectRowHeight() {
        let expectedRowHeight = CGFloat(100)
        
        existingViewModelSection.sectionRowsData[0].height = expectedRowHeight
        viewModel.sectionsDisplayData[0] = existingViewModelSection
        sut.didLoadInitialData(in: viewModel.erased)
        
        let indexPath = IndexPath(row: 0, section: 0)
        let rowHeightToEvaluate = tableView.delegate?.tableView?(tableView, heightForRowAt: indexPath)
        
        XCTAssertEqual(expectedRowHeight, rowHeightToEvaluate)
    }
    
    func test_LoadingInitialDataWithCorrectNumberOfRowsForEachSection() {
        var section = SectionDisplayDataStub(headerDisplayData: nil, sectionRowsData: [])
        viewModel.sectionsDisplayData.append(section.erased)
        
        let cellDisplayData = FakeCellDisplayData()
        section = SectionDisplayDataStub(headerDisplayData: nil, sectionRowsData: [cellDisplayData, cellDisplayData, cellDisplayData])
        viewModel.sectionsDisplayData.append(section.erased)
        
        section = SectionDisplayDataStub(headerDisplayData: nil, sectionRowsData: [cellDisplayData])
        viewModel.sectionsDisplayData.append(section.erased)
        
        sut.didLoadInitialData(in: viewModel.erased)
        
        XCTAssertEqual(tableView.dataSource!.tableView(tableView, numberOfRowsInSection: 1), 0)
        XCTAssertEqual(tableView.dataSource!.tableView(tableView, numberOfRowsInSection: 2), 3)
        XCTAssertEqual(tableView.dataSource!.tableView(tableView, numberOfRowsInSection: 3), 1)
    }
    
    func test_RemovingTheOnlySection() {
        let expectedNumberOfSections = 0
        
        viewModel.sectionsDisplayData.remove(at: 0)
        sut.didRemoveSections(at: [0], in: viewModel.erased, animated: false)
        let updatedNumberOfSections = tableView.dataSource?.numberOfSections?(in: tableView)
        
        XCTAssertEqual(expectedNumberOfSections, updatedNumberOfSections)
    }
    
    func test_WhenRemovingASectionInBetweenOtherSections_MakeSureToRemoveTheRightOne() {
        
        var cellDisplayData = FakeCellDisplayData()
        cellDisplayData.height = 1
        var section = SectionDisplayDataStub(headerDisplayData: nil, sectionRowsData: [cellDisplayData])
        viewModel.sectionsDisplayData.append(section.erased)
        
        cellDisplayData = FakeCellDisplayData()
        cellDisplayData.height = 2
        section = SectionDisplayDataStub(headerDisplayData: nil, sectionRowsData: [cellDisplayData])
        viewModel.sectionsDisplayData.append(section.erased)
        
        cellDisplayData = FakeCellDisplayData()
        cellDisplayData.height = 3
        section = SectionDisplayDataStub(headerDisplayData: nil, sectionRowsData: [cellDisplayData])
        viewModel.sectionsDisplayData.append(section.erased)
        
        sut.didLoadInitialData(in: viewModel.erased)
        
        viewModel.sectionsDisplayData.remove(at: 2)
        sut.didRemoveSections(at: [2], in: viewModel.erased, animated: false)
        
        let secondSectionRowIndexPath = IndexPath(row: 0, section: 1)
        let thirdSectionRowIndexPath = IndexPath(row: 0, section: 2)
        XCTAssertEqual(tableView.delegate?.tableView?(tableView, heightForRowAt: secondSectionRowIndexPath), 1)
        XCTAssertEqual(tableView.delegate?.tableView?(tableView, heightForRowAt: thirdSectionRowIndexPath), 3)
    }
    
    func test_ToInsertARowAtTheEndOfTheFirstSection() {
        assertRowInsertion(at: 1, inSectionAt: 0)
    }
    
    func test_ToInsertARowAtTheBeginningOfTheFirstSection() {
        assertRowInsertion(at: 0, inSectionAt: 0)
    }
    
    func test_ToInsertARowInTheMiddleOfTheSecondSection() {
        let section = getNewSection(headerHeight: 0, numberOfRows: 2, rowHeight: 10)
        insert(newSections: [section])
        assertRowInsertion(at: 1, inSectionAt: 1)
    }
    
    func test_UpdatingTheRowInInitialSection() {
        let indexPath = IndexPath(row: 0, section: 0)
        assertRowChange(at: indexPath, operationType: .update)
    }
    
    func test_UpdatingTheRowInANewSection() {
        let newSection = getNewSection(headerHeight: 10, numberOfRows: 3, rowHeight: 20)
        insert(newSections: [newSection])
        
        let indexPath = IndexPath(row: 1, section: 1)
        assertRowChange(at: indexPath, operationType: .update)
    }
    
    func test_WhenUpdatingAnItem_TableViewDoesntReplaceTheCellView() {
        let indexPath = IndexPath(row: 0, section: 0)
        let cellDescription = tableView.cellForRow(at: indexPath)?.description
        sut.didUpdate(itemsAt: [indexPath], in: viewModel.erased)
        let cellDescriptionAfterUpdate = tableView.cellForRow(at: indexPath)?.description
        XCTAssertEqual(cellDescription, cellDescriptionAfterUpdate)
    }
    
    func test_WhenReplacingAnItem_TableViewDoesntReplaceTheCellView() {
        let indexPath = IndexPath(row: 0, section: 0)
        let cellDescription = tableView.cellForRow(at: indexPath)?.description
        sut.didReplace(itemsAt: [indexPath], in: viewModel.erased)
        let cellDescriptionAfterUpdate = tableView.cellForRow(at: indexPath)?.description
        XCTAssertNotEqual(cellDescription, cellDescriptionAfterUpdate)
    }
    
    func test_ReplacingTheRowInInitialSection() {
        let indexPath = IndexPath(row: 0, section: 0)
        assertRowChange(at: indexPath, operationType: .replace)
    }
    
    func test_ReplacingTheRowInANewSection() {
        let newSection = getNewSection(headerHeight: 10, numberOfRows: 4, rowHeight: 20)
        insert(newSections: [newSection])
        
        let indexPath = IndexPath(row: 2, section: 1)
        assertRowChange(at: indexPath, operationType: .replace)
    }
    
    func test_RemovingTheOnlyCellInTableView() {
        let indexPath = IndexPath(row: 0, section: 0)
        let newSection = getNewSection(headerHeight: 0, numberOfRows: 0)
        viewModel.sectionsDisplayData[0] = newSection.erased
        sut.didRemove(itemsFrom: [indexPath], in: viewModel.erased, animated: false)
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 0)
    }
    
    func test_RemovingANewlyAddedCellInTableView() {
        let section = getNewSection(headerHeight: 0, numberOfRows: 5, rowHeight: 10)
        let anotherSection = getNewSection(headerHeight: 0, numberOfRows: 2, rowHeight: 10)
        insert(newSections: [section, anotherSection])
        
        let indexPath = IndexPath(row: 2, section: 1)
        let newSection = getNewSection(headerHeight: 0, numberOfRows: 4, rowHeight: 10)
        viewModel.sectionsDisplayData[1] = newSection.erased
        sut.didRemove(itemsFrom: [indexPath], in: viewModel.erased, animated: false)
        XCTAssertEqual(tableView.numberOfRows(inSection: 1), 4)
    }
    
    private func assertNewHeaderAndRowHeights(in sectionIndex: Int, with delegateCall: () -> Void, lineNumber: UInt = #line) {
        let updatedRowHeight = CGFloat(10)
        let updatedHeaderHeight = CGFloat(5)
        
        existingViewModelSection.headerDisplayData?.height = updatedHeaderHeight
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
    
    private func assertNumberOfSectionsInTableView(sectionsToAdd: [SectionDataAlias], testFailAt lineNumber: UInt = #line) {
        let expectedNumberOfSections = sectionsToAdd.count + 1
        
        insert(newSections: sectionsToAdd)
        
        let assertMessage = "The number of sections is not " + String(expectedNumberOfSections)
        XCTAssertEqual(tableView.numberOfSections, expectedNumberOfSections, assertMessage, line: lineNumber)
    }
    
    private func assertRowInsertion(at index: Int, inSectionAt sectionIndex: Int, lineNumber: UInt = #line) {
        let expectedRowHeight = CGFloat(1)
        let indexPathToInsertTo = IndexPath(row: index, section: sectionIndex)
        
        var oldRows = viewModel.sectionsDisplayData[sectionIndex].sectionRowsData
        let rowDisplayData = FakeCellDisplayData()
        rowDisplayData.height = expectedRowHeight
        oldRows.insert(rowDisplayData, at: index)
        let newSection = SectionDisplayDataStub(headerDisplayData: nil, sectionRowsData: oldRows)
        
        viewModel.sectionsDisplayData[sectionIndex] = newSection.erased
        sut.didInsert(itemsAt: [indexPathToInsertTo], in: viewModel.erased, animated: false)
        
        let assertMessage = "Didn't insert row correctly"
        XCTAssertEqual(tableView.delegate!.tableView?(tableView, heightForRowAt: indexPathToInsertTo), expectedRowHeight, assertMessage, line: lineNumber)
    }
    
    private func assertRowChange(at indexPath: IndexPath, operationType: RowOperationType, lineNumber: UInt = #line) {
        tableView.frame = CGRect(x: 0, y: 0, width: 300, height: 400)
        tableView.cellForRow(at: indexPath)
        
        let initialConfigurationTimes = cellConfiguratorFactory.numberOfTimesCalledToConfigureRow
        let expectedConfigurationTimes = initialConfigurationTimes + 1
        let expectedRowHeight = CGFloat(199)
        
        viewModel.sectionsDisplayData[indexPath.section].sectionRowsData[indexPath.row].height = expectedRowHeight
        
        switch operationType {
        case .replace:
            sut.didReplace(itemsAt: [indexPath], in: viewModel.erased)
        case .update:
            sut.didUpdate(itemsAt: [indexPath], in: viewModel.erased)
        }
        
        XCTAssertEqual(tableView.delegate?.tableView?(tableView, heightForRowAt: indexPath), expectedRowHeight, line: lineNumber)
        XCTAssertEqual(cellConfiguratorFactory.numberOfTimesCalledToConfigureRow, expectedConfigurationTimes, line: lineNumber)
    }
    
    private func insert(newSections: [SectionDataAlias]) {
        viewModel.sectionsDisplayData.append(contentsOf: newSections)
        
        var startingIndex: Int = 0
        let indexesInserted = newSections.map { _ -> Int in
            startingIndex += 1;
            return startingIndex
        }
        sut.didInsertSections(at: indexesInserted, in: viewModel.erased, animated: false)
    }
    
    private func getNewSection(headerHeight: CGFloat = 0, numberOfRows: UInt = 1, rowHeight: CGFloat = 0) -> SectionDataAlias {
        let newHeader = FakeHeaderDisplayData()
        newHeader.height = headerHeight
        var rows = [FakeCellDisplayData]()
        (0..<numberOfRows).forEach { (_) in
            let row = FakeCellDisplayData()
            rows.append(row)
        }
        let section = SectionDisplayDataStub(headerDisplayData: newHeader, sectionRowsData: rows)
        return section.erased
    }
    
    private func addHeadersToTableView() {
        let headerConfiguratorFactory = HeaderConfiguratorFactoryMock()
        tableViewBuilder.addHeaders(with: headerConfiguratorFactory, from: viewModel)
    }
}

extension TableViewModelDelegateTests {
    enum RowOperationType {
        case update, replace
    }
}
