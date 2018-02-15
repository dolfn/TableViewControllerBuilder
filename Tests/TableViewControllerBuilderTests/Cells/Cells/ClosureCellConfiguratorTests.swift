//
//  ClosureCellConfiguratorTests.swift
//  Copyright © 2018 Dolfn. All rights reserved.
//

import XCTest
@testable import TableViewControllerBuilder

class ClosureCellConfiguratorTests: XCTestCase {
    
    var reuseIdentifier: String!
    var tableView: UITableViewSpy!
    
    override func setUp() {
        super.setUp()
        reuseIdentifier = UUID().uuidString
        tableView = UITableViewSpy()
    }
    
    override func tearDown() {
        reuseIdentifier = nil
        tableView = nil
        super.tearDown()
    }
    
    func test_RegisterTableViewCell_ForGivenUUID() {
        let sut = ClosureCellConfigurator<FakeCellDisplayData, UITableViewCell>(reuseIdentifier: reuseIdentifier) { (_, _) in
        }
        sut.register(in: tableView)
        XCTAssertNotNil(tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: IndexPath(row: 0, section: 0)))
    }
    
    func test_RegisterTableViewCellWithoutCompletionBlock_ForGivenUUID() {
        let sut = ClosureCellConfigurator<FakeCellDisplayData, UITableViewCell> { (_, _) in
            
        }
        sut.register(in: tableView)
        XCTAssertNotNil(tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: IndexPath(row: 0, section: 0)))
    }
    
    func test_ConfigureCell_IsCallingConfigureClosure() {
        let expect = expectation(description: "Configure given tableview cell")
        let sut = ClosureCellConfigurator<FakeCellDisplayData, UITableViewCell>(reuseIdentifier: reuseIdentifier) { (_, _) in
            expect.fulfill()
        }
        sut.register(in: tableView)
        _ = sut.configuredCell(in: tableView, at: IndexPath(row: 0, section: 0), with: FakeCellDisplayData())
        wait(for: [expect], timeout: 0.1)
    }
    
    func test_ReconfigureCell_ReturnWithoutCallingConfiguratorIfCellDoesNotExists() {
        let sut = ClosureCellConfigurator<FakeCellDisplayData, UITableViewCell> { (_, _) in
            XCTFail()
        }
        tableView.shouldReturnCell = false
        sut.register(in: tableView)
        sut.reconfigureCell(in: tableView, at: IndexPath(row: 0, section: 0), with: FakeCellDisplayData())
        wait(for: 0.1)
    }
    
    func test_ReconfigureCell_IsCallingReconfigureClosure() {
        let expect = expectation(description: "Reconfigure given tableview cell")
        let initialData = FakeCellDisplayData()
        let reconfigureData = FakeCellDisplayData()
        
        let sut = ClosureCellConfigurator<FakeCellDisplayData, UITableViewCell> { (_, dataToConfigureWith) in
            if dataToConfigureWith == reconfigureData {
                expect.fulfill()
            }
        }
        sut.register(in: tableView)
        _ = sut.configuredCell(in: tableView, at: IndexPath(row: 0, section: 0), with: initialData)
        sut.reconfigureCell(in: tableView, at: IndexPath(row: 0, section: 0), with: reconfigureData)
        wait(for: [expect], timeout: 0.1)
    }
}
