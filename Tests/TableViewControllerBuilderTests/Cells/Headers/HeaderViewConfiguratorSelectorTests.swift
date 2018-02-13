//
//  HeaderViewConfiguratorSelectorTests.swift
//  Copyright © 2018 Dolfn. All rights reserved.
//

import XCTest
@testable import TableViewControllerBuilder

class HeaderViewConfiguratorSelectorTests: XCTestCase {
    
    var headerConfiguratorFactorySpy: HeaderConfiguratorFactorySpy!
    var sut: HeaderViewConfiguratorSelector<FakeHeaderDisplayData>!
    var tableView: UITableView!
    var configurator: ClosureHeaderConfigurator<FakeHeaderDisplayData, UITableViewHeaderFooterView>!
    
    override func setUp() {
        super.setUp()
        headerConfiguratorFactorySpy = HeaderConfiguratorFactorySpy()
        sut = HeaderViewConfiguratorSelector(configuratorFactory: headerConfiguratorFactorySpy)
        tableView = UITableView()
    }
    
    override func tearDown() {
        headerConfiguratorFactorySpy = nil
        sut = nil
        tableView = nil
        configurator = nil
        super.tearDown()
    }
    
    func test_IfHeaderConfigurationFactoryDoesNotProvideConfigurator_ReturnNil() {
        XCTAssertNil(sut.configuredHeader(in: tableView, at: 0, with: FakeHeaderDisplayData()))
    }
    
    func test_ConfigureHeaderView_WithGivenConfigurator() {
        let expect = expectation(description: "Configure given tableview header footer view")
        configurator = ClosureHeaderConfigurator<FakeHeaderDisplayData, UITableViewHeaderFooterView> { (_, _) in
            expect.fulfill()
        }
        headerConfiguratorFactorySpy.configuratorToReturn = configurator.erased
        _ = sut.configuredHeader(in: tableView, at: 0, with: FakeHeaderDisplayData())
        wait(for: [expect], timeout: 0.5)
    }
    
}
