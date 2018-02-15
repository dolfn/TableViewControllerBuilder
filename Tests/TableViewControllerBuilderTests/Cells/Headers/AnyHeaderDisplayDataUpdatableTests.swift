//
//  AnyHeaderDisplayDataUpdatableTests.swift
//  Copyright © 2018 Dolfn. All rights reserved.
//

import XCTest
@testable import TableViewControllerBuilder

class AnyHeaderDisplayDataUpdatableTests: XCTestCase {
    
    var updatable: HeaderDisplayDataUpdatableSpy!
    var sut: AnyHeaderDisplayDataUpdatable<FakeHeaderDisplayData>!
    
    override func setUp() {
        super.setUp()
        updatable = HeaderDisplayDataUpdatableSpy()
        sut = AnyHeaderDisplayDataUpdatable(updatable: updatable)
    }
    
    override func tearDown() {
        updatable = nil
        sut = nil
        super.tearDown()
    }
    
    func test_GivenHeaderDisplayDataToUpdate_IsCallingGivenUpdatableFunction() {
        let data = [FakeHeaderDisplayData(), FakeHeaderDisplayData()]
        sut.update(headerDisplayData: data)
        XCTAssertEqual(updatable.headerDisplayData?.count, 2)
        for aGivenData in data {
            let found = updatable.headerDisplayData?.contains(where: { (aHeaderDisplayData) -> Bool in
                if let aHeaderDisplayData = aHeaderDisplayData {
                    return aHeaderDisplayData == aGivenData
                }
                return false
            })
            
            if found == nil {
                XCTFail()
            }
        }
    }
    
    func test_GivenEmptyArrayToUpdate_IsProvingEmptyArrayToUpdatableFunction() {
        sut.update(headerDisplayData: [])
        XCTAssertEqual(updatable.headerDisplayData?.count, 0)
    }
    
}
