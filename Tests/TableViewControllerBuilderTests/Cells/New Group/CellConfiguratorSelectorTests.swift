//
//  CellConfiguratorSelectorTests.swift
//  TableViewControllerBuilder-iOS Tests
//
//  Created by Andrei Nastasiu on 09/02/2018.
//  Copyright © 2018 Dolfn. All rights reserved.
//

import XCTest
@testable import TableViewControllerBuilder

class CellConfiguratorSelectorTests: XCTestCase {
    
    func test_CallingRegister_DoesNotChangeTableViewState() {
        let cellConfiguratorFactory = CellConfiguratorFactoryMock()
        let sut = CellConfiguratorSelector(configuratorFactory: cellConfiguratorFactory)
        let tableView = UITableView()
        sut.register(in: tableView)
        XCTAssertNil(tableView.dequeueReusableCell(withIdentifier: "FakeCellDisplayData"))
    }
    
}
