//
//  AnyHeaderDisplayDataUpdatableTests.swift
//  Copyright © 2018 Dolfn. All rights reserved.
//

import XCTest
@testable import TableViewControllerBuilder

class AnyHeaderDisplayDataUpdatableTests: XCTestCase {
    
    func test_GivenHeaderDisplayDataToUpdate_IsCallingGivenUpdatableFunction() {
        let updatable = HeaderDisplayDataUpdatableSpy()
        let sut = AnyHeaderDisplayDataUpdatable(updatable: updatable)
        let data = [FakeHeaderDisplayData(), FakeHeaderDisplayData()]
        sut.update(headerDisplayData: data)
        XCTAssertEqual(updatable.headerDisplayData?.count, 2)
        for aGivenData in data {
            let found = updatable.headerDisplayData?.contains(where: { (aHeaderDisplayData) -> Bool in
                if let aHeaderDisplayData = aHeaderDisplayData {
                    return aHeaderDisplayData === aGivenData
                }
                return false
            })
            
            if found == nil {
                XCTFail()
            }
        }
    }
    
}
