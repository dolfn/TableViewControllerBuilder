//
//  ClosureCellConfiguratorExtensionsTests.swift
//  Copyright © 2018 Dolfn. All rights reserved.
//

import XCTest
@testable import TableViewControllerBuilder

class ClosureCellConfiguratorExtensionsTests: XCTestCase {
    
    func test_GivenClouseCellConfigurator_IsReturnedAsErased() {
        let uuid = UUID().uuidString
        let configurator = ClosureCellConfigurator<Any, UITableViewCell>(reuseIdentifier: uuid) { (_, _) in
            
        }
        let erased = configurator.erased
        XCTAssertEqual(erased.reuseIdentifier, uuid)
    }
    
}
