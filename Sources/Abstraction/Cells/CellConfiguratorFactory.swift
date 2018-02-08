//
//  CellConfiguratorFactory.swift
//  Copyright © 2017 Dolfn. All rights reserved.
//

import Foundation

public protocol CellConfiguratorFactory {
    associatedtype CellDisplayData
    
    func cellConfigurator(with cellDisplayData: CellDisplayData) -> AnyClosureCellConfigurator<CellDisplayData>
}
