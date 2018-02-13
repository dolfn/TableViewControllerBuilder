//
//  ClosureCellConfiguratorTests.swift
//  Copyright © 2018 Dolfn. All rights reserved.
//

import XCTest
@testable import TableViewControllerBuilder

class ClosureCellConfiguratorTests: XCTestCase {
    
    func test_RegisterTableViewCell_ForGivenUUID() {
        let reuseIdentifier = UUID().uuidString
        let tableView = UITableView()
        let sut = ClosureCellConfigurator<FakeCellDisplayData, UITableViewCell>(reuseIdentifier: reuseIdentifier) { (_, _) in
        }
        sut.register(in: tableView)
        XCTAssertNotNil(tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: IndexPath(row: 0, section: 0)))
    }
    
    func test_RegisterTableViewCellWithoutCompletionBlock_ForGivenUUID() {
        let tableView = UITableView()
        let sut = ClosureCellConfigurator<FakeCellDisplayData, UITableViewCell> { (_, _) in
            
        }
        sut.register(in: tableView)
        XCTAssertNotNil(tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: IndexPath(row: 0, section: 0)))
    }
    
    func test_ConfigureCell_IsCallingConfigureClosure() {
        let reuseIdentifier = UUID().uuidString
        let tableView = UITableView()
        let expect = expectation(description: "Configure given tableview cell")
        let sut = ClosureCellConfigurator<FakeCellDisplayData, UITableViewCell>(reuseIdentifier: reuseIdentifier) { (_, _) in
            expect.fulfill()
        }
        sut.register(in: tableView)
        _ = sut.configuredCell(in: tableView, at: IndexPath(row: 0, section: 0), with: FakeCellDisplayData())
        wait(for: [expect], timeout: 0.1)
    }
    
}
