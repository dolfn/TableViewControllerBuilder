//
//  HeaderConfiguratorFactoryMock.swift
//  Copyright © 2018 Dolfn. All rights reserved.
//

import Foundation

class HeaderConfiguratorFactoryMock: HeaderConfiguratorFactory {
    
    typealias HeaderDisplayDataType = FakeHeaderDisplayData
    
    func configurator(with displayDataType: FakeHeaderDisplayData) -> AnyHeaderViewConfigurator<FakeHeaderDisplayData>? {
        let configurator = ClosureHeaderConfigurator {(displayData: FakeHeaderDisplayData, UITableViewHeaderFooterView) in }
        return AnyHeaderViewConfigurator(baseConfigurator: configurator)
    }
    
}
