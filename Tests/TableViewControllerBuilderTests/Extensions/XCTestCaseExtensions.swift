//
//  XCTestCaseExtensions.swift
//  TableViewControllerBuilder-iOS
//
//  Created by Andrei Nastasiu on 05/02/2018.
//  Copyright © 2018 Dolfn. All rights reserved.
//

import XCTest

extension XCTestCase {
    func wait(for duration: TimeInterval) {
        let waitExpectation = expectation(description: "Waiting")
        let when = DispatchTime.now() + duration
        DispatchQueue.main.asyncAfter(deadline: when) {
            waitExpectation.fulfill()
        }
        waitForExpectations(timeout: duration + 0.5)
    }
}
