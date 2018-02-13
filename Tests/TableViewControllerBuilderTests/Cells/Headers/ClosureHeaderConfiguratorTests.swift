//
//  ClosureHeaderConfiguratorTests.swift
//  Copyright © 2018 Dolfn. All rights reserved.
//

import XCTest
import UIKit
@testable import TableViewControllerBuilder

class ClosureHeaderConfiguratorTests: XCTestCase {

    func test_RegisterTableViewHeaderFooterView_ForGivenUUID() {
        let reuseIdentifier = UUID().uuidString
        let sut = ClosureHeaderConfigurator<FakeHeaderDisplayData, UITableViewHeaderFooterView>(reuseIdentifier: reuseIdentifier) { (_, _) in
        }
        let tableView = UITableView()
        sut.register(in: tableView)
        XCTAssertNotNil(tableView.dequeueReusableHeaderFooterView(withIdentifier: reuseIdentifier))
    }
}
