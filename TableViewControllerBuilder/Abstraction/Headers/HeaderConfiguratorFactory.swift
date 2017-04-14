//
//  HeaderConfiguratorFactory.swift
//  TableViewControllerBuilder
//
//  Created by Corneliu on 13/04/2017.
//  Copyright © 2017 Corneliu. All rights reserved.
//

import Foundation

protocol HeaderConfiguratorFactory {
    associatedtype HeaderDisplayDataType
    func configurator(with displayDataType: HeaderDisplayDataType) -> AnyHeaderViewConfigurator<HeaderDisplayDataType>?
}
