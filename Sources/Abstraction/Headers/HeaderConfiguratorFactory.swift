//
//  HeaderConfiguratorFactory.swift
//  Copyright © 2017 Dolfn. All rights reserved.
//

import Foundation

public protocol HeaderConfiguratorFactory {
    associatedtype HeaderDisplayDataType
    
    func configurator(with displayDataType: HeaderDisplayDataType) -> AnyHeaderViewConfigurator<HeaderDisplayDataType>?
}
