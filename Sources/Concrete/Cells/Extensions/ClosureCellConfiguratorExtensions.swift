//
//  ClosureCellConfiguratorExtensions.swift
//  Copyright © 2017 Dolfn. All rights reserved.
//

import Foundation

public extension ClosureCellConfigurator {
    var erased: AnyClosureCellConfigurator<CellDisplayDataType> {
        return AnyClosureCellConfigurator(base: self)
    }
}
