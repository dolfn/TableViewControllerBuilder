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
    
}
