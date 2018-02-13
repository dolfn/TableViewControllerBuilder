//
//  ClosureHeaderConfiguratorTests.swift
//  Copyright © 2018 Dolfn. All rights reserved.
//

import XCTest
import UIKit
@testable import TableViewControllerBuilder

class ClosureHeaderConfiguratorTests: XCTestCase {

    var reuseIdentifier: String!
    var tableView: UITableView!
    
    override func setUp() {
        super.setUp()
        reuseIdentifier = UUID().uuidString
        tableView = UITableView()
    }
    
    override func tearDown() {
        reuseIdentifier = nil
        tableView = nil
        super.tearDown()
    }
    
    func test_RegisterTableViewHeaderFooterView_ForGivenUUID() {
        let sut = ClosureHeaderConfigurator<FakeHeaderDisplayData, UITableViewHeaderFooterView>(reuseIdentifier: reuseIdentifier) { (_, _) in
        }
        sut.register(in: tableView)
        XCTAssertNotNil(tableView.dequeueReusableHeaderFooterView(withIdentifier: reuseIdentifier))
    }
    
    func test_CallingConfigureHeaderFooterView_CallGivenConfigurationClosure() {
        let expect = expectation(description: "Configure given tableview header footer view")
        let sut = ClosureHeaderConfigurator<FakeHeaderDisplayData, UITableViewHeaderFooterView>(reuseIdentifier: reuseIdentifier) { (_, _) in
            expect.fulfill()
        }
        sut.register(in: tableView)
        _ = sut.configuredHeader(in: tableView, at: 0, with: FakeHeaderDisplayData())
        wait(for: [expect], timeout: 0.1)
    }
}
