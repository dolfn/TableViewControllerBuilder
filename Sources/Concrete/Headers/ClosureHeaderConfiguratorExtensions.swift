//
//  ClosureHeaderConfiguratorExtensions.swift
//  Copyright © 2017 Dolfn. All rights reserved.
//

import Foundation

public extension ClosureHeaderConfigurator {
    public var erased: AnyHeaderViewConfigurator<HeaderDisplayDataType> {
        return AnyHeaderViewConfigurator(baseConfigurator: self)
    }
}
