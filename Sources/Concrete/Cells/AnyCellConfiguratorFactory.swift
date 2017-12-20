//
//  AnyClosureCellConfiguratorFactory.swift
//  Copyright © 2017 Dolfn. All rights reserved.
//

import Foundation

struct AnyClosureCellConfiguratorFactory<CellDisplayDataType>: CellConfiguratorFactory {
    
    private let cellConfiguratorFactoryClosure: (CellDisplayDataType) -> AnyClosureCellConfigurator<CellDisplayDataType>
    
    init<CellConfiguratorFactoryType: CellConfiguratorFactory>(cellConfiguratorFactory: CellConfiguratorFactoryType) where CellConfiguratorFactoryType.CellDisplayData == CellDisplayDataType {
        cellConfiguratorFactoryClosure = cellConfiguratorFactory.cellConfigurator
    }
    
    func cellConfigurator(with cellDisplayData: CellDisplayDataType) -> AnyClosureCellConfigurator<CellDisplayDataType> {
        return cellConfiguratorFactoryClosure(cellDisplayData)
    }
}
