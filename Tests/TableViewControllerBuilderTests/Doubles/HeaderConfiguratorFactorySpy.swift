//
//  HeaderConfiguratorFactorySpy.swift
//  Copyright © 2018 Dolfn. All rights reserved.
//

import Foundation

class HeaderConfiguratorFactorySpy: HeaderConfiguratorFactory {
    
    typealias HeaderDisplayDataType = FakeHeaderDisplayData
    
    var displayDataType: FakeHeaderDisplayData?
    var configuratorToReturn: AnyHeaderViewConfigurator<FakeHeaderDisplayData>?
    
    func configurator(with displayDataType: FakeHeaderDisplayData) -> AnyHeaderViewConfigurator<FakeHeaderDisplayData>? {
        self.displayDataType = displayDataType
        return configuratorToReturn
    }
    
}
