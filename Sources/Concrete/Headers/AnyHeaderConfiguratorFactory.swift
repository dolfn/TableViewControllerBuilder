//
//  AnyHeaderConfiguratorFactory.swift
//  TableViewControllerBuilder
//
//  Created by Corneliu on 13/04/2017.
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
