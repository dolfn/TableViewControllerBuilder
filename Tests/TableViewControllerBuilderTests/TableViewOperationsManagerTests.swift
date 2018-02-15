//
//  TableViewOperationsManagerTests.swift
//  Copyright © 2018 Dolfn. All rights reserved.
//

import XCTest
@testable import TableViewControllerBuilder

class TableViewOperationsManagerTests: XCTestCase {

    var sut: TableViewOperationsManager<FakeHeaderDisplayData, FakeCellDisplayData>!
    var tableView: UITableViewSpy!
    var cellReconfiguratorSpy: CellReconfiguratorSpy!
    var anyViewModel: AnyTableViewModel<FakeHeaderDisplayData, FakeCellDisplayData>!
    var rowDataUpdatableSpy: CellDisplayDataUpdatableSpy!
    var rowHeightsDataUpdatableSpy: CellDisplayDataUpdatableSpy!
    var headerDataUpdatableSpy: HeaderDisplayDataUpdatableSpy!
    var newSection: SectionDataAlias!
    
    override func setUp() {
        super.setUp()
        cellReconfiguratorSpy = CellReconfiguratorSpy()
        sut = TableViewOperationsManager<FakeHeaderDisplayData, FakeCellDisplayData>(cellReconfigurator: cellReconfiguratorSpy)
        tableView = UITableViewSpy()
        sut.tableView = tableView
        
        rowDataUpdatableSpy = CellDisplayDataUpdatableSpy()
        let rowDataUpdatable = AnyCellDisplayDataUpdatable(updatable: rowDataUpdatableSpy)
        sut.rowDataUpdatable = rowDataUpdatable
        
        rowHeightsDataUpdatableSpy = CellDisplayDataUpdatableSpy()
        let rowHeightsDataUpdatable = AnyCellDisplayDataUpdatable(updatable: rowHeightsDataUpdatableSpy)
        sut.rowHeightsDataUpdatable = rowHeightsDataUpdatable
        
        headerDataUpdatableSpy = HeaderDisplayDataUpdatableSpy()
        let headerDataUpdatable = AnyHeaderDisplayDataUpdatable(updatable: headerDataUpdatableSpy)
        sut.headerDataUpdatable = headerDataUpdatable
        
        var viewModel = TableViewModelStub()
        newSection = getNewSection(headerHeight: 10, numberOfRows: 3, rowHeight: 15, estimatedRowHeight: 15)
        viewModel.sectionsDisplayData = [newSection]
        anyViewModel = AnyTableViewModel(tableViewModel: viewModel)
    }
    
    override func tearDown() {
        cellReconfiguratorSpy = nil
        sut = nil
        tableView = nil
        anyViewModel = nil
        rowDataUpdatableSpy = nil
        rowHeightsDataUpdatableSpy = nil
        headerDataUpdatableSpy = nil
        newSection = nil
        super.tearDown()
    }
    
    func test_GivenReconfigurator_IsRetainedWeak() {
        var cellReconfiguratorSpy: CellReconfigurator? = CellReconfiguratorSpy()
        sut = TableViewOperationsManager<FakeHeaderDisplayData, FakeCellDisplayData>(cellReconfigurator: cellReconfiguratorSpy!)
        weak var reference: CellReconfigurator? = cellReconfiguratorSpy
        cellReconfiguratorSpy = nil
        XCTAssertNil(reference)
    }
    
    func test_GivenTableView_IsRetainedWeak() {
        weak var reference: UITableViewSpy? = sut.tableView as? UITableViewSpy
        tableView = nil
        XCTAssertNil(reference)
    }
    
    func test_GivenUpdatables_AreRetainedStrong() {
        let cellReconfiguratorSpy: CellReconfigurator? = CellReconfiguratorSpy()
        sut = TableViewOperationsManager<FakeHeaderDisplayData, FakeCellDisplayData>(cellReconfigurator: cellReconfiguratorSpy!)

        let rowDataUpdatable = AnyCellDisplayDataUpdatable(updatable: CellDisplayDataUpdatableSpy())
        sut.rowDataUpdatable = rowDataUpdatable

        let rowHeightsDataUpdatable = AnyCellDisplayDataUpdatable(updatable: CellDisplayDataUpdatableSpy())
        sut.rowHeightsDataUpdatable = rowHeightsDataUpdatable

        let headerDataUpdatable = AnyHeaderDisplayDataUpdatable(updatable: HeaderDisplayDataUpdatableSpy())
        sut.headerDataUpdatable = headerDataUpdatable
        
        wait(for: 0.1)
        
        XCTAssertNotNil(rowDataUpdatable)
        XCTAssertNotNil(rowHeightsDataUpdatable)
        XCTAssertNotNil(headerDataUpdatable)
    }
    
    func test_SetupTableView_WithGivenInitialData() {
        sut.didLoadInitialData(in: anyViewModel)
        
        XCTAssertEqual(tableView.reloadDataCounter, 1)
        XCTAssertTrue(compareEqual(cellsDisplayData: [newSection.sectionRowsData], with: rowDataUpdatableSpy.cellsDisplayData))
        XCTAssertTrue(compareEqual(cellsDisplayData: [newSection.sectionRowsData], with: rowHeightsDataUpdatableSpy.cellsDisplayData))
        XCTAssertTrue(compareEqual(headersDisplayData: [newSection.headerDisplayData], with: headerDataUpdatableSpy.headerDisplayData))
    }
    
    func test_UpdatingSectionsNotAnimated() {
        sut.didUpdateSection(at: 0, in: anyViewModel.erased, animated: false)
        
        XCTAssertEqual(tableView.animation, UITableViewRowAnimation.none)
        XCTAssertEqual(tableView.sections, IndexSet(integer: 0))
        XCTAssertTrue(compareEqual(cellsDisplayData: [newSection.sectionRowsData], with: rowDataUpdatableSpy.cellsDisplayData))
        XCTAssertTrue(compareEqual(cellsDisplayData: [newSection.sectionRowsData], with: rowHeightsDataUpdatableSpy.cellsDisplayData))
        XCTAssertTrue(compareEqual(headersDisplayData: [newSection.headerDisplayData], with: headerDataUpdatableSpy.headerDisplayData))
    }
    
    func test_UpdatingSectionsAnimated() {
        sut.didUpdateSection(at: 0, in: anyViewModel.erased, animated: true)
        
        XCTAssertEqual(tableView.animation, UITableViewRowAnimation.automatic)
        XCTAssertEqual(tableView.sections, IndexSet(integer: 0))
        XCTAssertTrue(compareEqual(cellsDisplayData: [newSection.sectionRowsData], with: rowDataUpdatableSpy.cellsDisplayData))
        XCTAssertTrue(compareEqual(cellsDisplayData: [newSection.sectionRowsData], with: rowHeightsDataUpdatableSpy.cellsDisplayData))
        XCTAssertTrue(compareEqual(headersDisplayData: [newSection.headerDisplayData], with: headerDataUpdatableSpy.headerDisplayData))
    }
    
    private func compareEqual(cellsDisplayData: [[FakeCellDisplayData]], with receivedCellsDisplayData: [[FakeCellDisplayData]]) -> Bool {
        if cellsDisplayData.count != receivedCellsDisplayData.count {
            return false
        }
        
        for index in 0 ..< cellsDisplayData.count {
            let firstHeader = cellsDisplayData[index]
            let firstReceivedHeader = receivedCellsDisplayData[index]
            
            if firstHeader.count != firstReceivedHeader.count {
                return false
            }
            
            for index2 in 0 ..< firstHeader.count {
                let firstHeaderData = firstHeader[index2]
                let firstReceivedHeaderData = firstReceivedHeader[index2]
                
                if firstHeaderData != firstReceivedHeaderData {
                    return false
                }
            }
        }
        
        return true
    }
    
    private func compareEqual(headersDisplayData: [FakeHeaderDisplayData?]?, with receivedHeadersDisplayData: [FakeHeaderDisplayData?]?) -> Bool {
        
        if headersDisplayData == nil && receivedHeadersDisplayData == nil {
            return true
        }
        
        guard let headersDisplayData = headersDisplayData, let receivedHeadersDisplayData = receivedHeadersDisplayData else {
            return false
        }
        
        if headersDisplayData.count != receivedHeadersDisplayData.count {
            return false
        }
        
        for index in 0 ..< headersDisplayData.count {
            let firstHeader = headersDisplayData[index]
            if let firstReceivedHeader = receivedHeadersDisplayData[index] {
                if firstHeader! != firstReceivedHeader {
                    return false
                }
            }
        }
        
        return true
    }
    
}
