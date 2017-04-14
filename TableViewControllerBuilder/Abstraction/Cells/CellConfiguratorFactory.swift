//
//  CellConfiguratorFactory.swift
//  TableViewControllerBuilder
//
//  Created by Corneliu on 13/04/2017.
//  Copyright © 2017 Corneliu. All rights reserved.
//

import Foundation

public protocol CellConfiguratorFactory {
    associatedtype CellDisplayData
    func cellConfigurator(with cellDisplayData: CellDisplayData) -> AnyClosureCellConfigurator<CellDisplayData>
}
