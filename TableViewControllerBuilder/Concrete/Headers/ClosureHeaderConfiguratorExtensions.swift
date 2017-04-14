//
//  ClosureHeaderConfiguratorExtensions.swift
//  TableViewControllerBuilder
//
//  Created by Corneliu on 10/04/2017.
//  Copyright © 2017 Corneliu. All rights reserved.
//

import Foundation

public extension ClosureHeaderConfigurator {
    public var erased: AnyHeaderViewConfigurator<HeaderDisplayDataType> {
        return AnyHeaderViewConfigurator(baseConfigurator: self)
    }
}
