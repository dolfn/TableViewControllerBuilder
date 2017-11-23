//
//  ExampleCellsConfiguratorFactory.swift
//  AnyCellHeadersTableViewTesting
//
//  Created by Corneliu on 10/04/2017.
//  Copyright © 2017 Dolfn. All rights reserved.
//

import Foundation
import TableViewControllerBuilder

struct ExampleCellsConfiguratorFactory: CellConfiguratorFactory {
    
    typealias CellDisplayData = ExampleCellDisplayDataType
    
    func cellConfigurator(with cellDisplayData: ExampleCellDisplayDataType) -> AnyClosureCellConfigurator<ExampleCellDisplayDataType> {
        switch cellDisplayData {
        case .Simple(let simpleCellData):
            let simpleCellConfigurator = ClosureCellConfigurator { (cell: DisclosureIndicatorTableViewCell, displayData: SimpleCellDisplayData) -> () in
                cell.textLabel?.text = displayData.title
            }
            return simpleCellConfigurator.erased.with(cellDisplayData: simpleCellData)
            
        case .Complex(let complexCellData):
            let cellConfigurator = ClosureCellConfigurator { (cell: TitleSubtitleTableViewCell, displayData: ComplexCellDisplayData) -> () in
                cell.title?.text = displayData.title
                cell.subtitle?.text = displayData.value
            }
            
            return cellConfigurator.erased.with(cellDisplayData: complexCellData)
        }
    }
}
