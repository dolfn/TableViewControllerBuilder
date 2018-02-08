//
//  AnyHeaderConfiguratorFactory.swift
//  Copyright © 2017 Dolfn. All rights reserved.
//

import Foundation

struct AnyHeaderConfiguratorFactory<HeaderDisplayDataType>: HeaderConfiguratorFactory {
    
    private let headerConfiguratorFactoryClosure: (HeaderDisplayDataType) -> AnyHeaderViewConfigurator<HeaderDisplayDataType>?
    
    init<HeaderConfiguratorFactoryType: HeaderConfiguratorFactory>(headerConfiguratorFactory: HeaderConfiguratorFactoryType) where HeaderConfiguratorFactoryType.HeaderDisplayDataType == HeaderDisplayDataType {
        headerConfiguratorFactoryClosure = headerConfiguratorFactory.configurator
    }
    
    func configurator(with displayDataType: HeaderDisplayDataType) -> AnyHeaderViewConfigurator<HeaderDisplayDataType>? {
        return headerConfiguratorFactoryClosure(displayDataType)
    }
}
