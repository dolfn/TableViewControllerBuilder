//
//  HeaderViewConfiguratorSelectorTests.swift
//  Copyright © 2018 Dolfn. All rights reserved.
//

import XCTest
@testable import TableViewControllerBuilder

class HeaderViewConfiguratorSelectorTests: XCTestCase {
    
    func test_IfHeaderConfigurationFactoryDoesNotProvideConfigurator_ReturnNil() {
        let headerConfiguratorFactorySpy = HeaderConfiguratorFactorySpy()
        let sut = HeaderViewConfiguratorSelector(configuratorFactory: headerConfiguratorFactorySpy)
        let tableView = UITableView()
        XCTAssertNil(sut.configuredHeader(in: tableView, at: 0, with: FakeHeaderDisplayData()))
    }
    
}
