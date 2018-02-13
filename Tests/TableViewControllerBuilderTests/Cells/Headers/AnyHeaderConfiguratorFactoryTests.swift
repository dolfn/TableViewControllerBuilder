//
//  AnyHeaderConfiguratorFactoryTests.swift
//  Copyright © 2018 Dolfn. All rights reserved.
//

import XCTest
@testable import TableViewControllerBuilder

class AnyHeaderConfiguratorFactoryTests: XCTestCase {
    
    func test_GivenHeaderDisplayData_IsReturnedErased() {
        let headerConfiguratorFactory = HeaderConfiguratorFactorySpy()
        let displayDataType = FakeHeaderDisplayData()
        let sut = AnyHeaderConfiguratorFactory(headerConfiguratorFactory: headerConfiguratorFactory)
        let _ = sut.configurator(with: displayDataType)
        XCTAssertTrue(headerConfiguratorFactory.displayDataType === displayDataType)
    }
    
}
