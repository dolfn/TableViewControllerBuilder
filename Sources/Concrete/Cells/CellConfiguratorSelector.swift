//
//  CellConfiguratorSelector.swift
//  Copyright © 2017 Dolfn. All rights reserved.
//

import UIKit

class CellConfiguratorSelector<CellDisplayDataType>: CellConfigurator {
    private let configuratorFactory: AnyClosureCellConfiguratorFactory<CellDisplayDataType>
    private var registered = [String]()
    
    init<CellConfiguratorFactoryType: CellConfiguratorFactory>(configuratorFactory: CellConfiguratorFactoryType) where CellConfiguratorFactoryType.CellDisplayData == CellDisplayDataType {
        self.configuratorFactory = AnyClosureCellConfiguratorFactory(cellConfiguratorFactory: configuratorFactory)
    }
    
    func register(in tableView: UITableView) {
        
    }
    
    func configuredCell(in tableView: UITableView, at indexPath: IndexPath, with cellDisplayData: CellDisplayDataType) -> UITableViewCell {
        let configurator = configuratorFactory.cellConfigurator(with: cellDisplayData)
        let reuseIdentifier = configurator.reuseIdentifier
        
        if !registered.contains(reuseIdentifier) {
            registered.append(reuseIdentifier)
            configurator.register(in: tableView)
        }
        
        return configurator.configuredCell(in: tableView, at: indexPath, with: cellDisplayData)
    }
    
    func reconfigureCell(in tableView: UITableView, at indexPath: IndexPath, with cellDisplayData: CellDisplayDataType) {
        let configurator = configuratorFactory.cellConfigurator(with: cellDisplayData)
        configurator.reconfigureCell(in: tableView, at: indexPath, with: cellDisplayData)
    }
}
