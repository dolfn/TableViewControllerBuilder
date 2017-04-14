//
//  HeaderViewConfiguratorSelector.swift
//  TableViewControllerBuilder
//
//  Created by Corneliu on 10/04/2017.
//  Copyright © 2017 Corneliu. All rights reserved.
//

import UIKit

class HeaderViewConfiguratorSelector<HeaderDisplayDataType>: HeaderConfigurator {
    
    private let configuratorFactory: AnyHeaderConfiguratorFactory<HeaderDisplayDataType>
    private var registeredIdentifiers = [String]()
    
    init<ConfiguratorFactoryType: HeaderConfiguratorFactory>(configuratorFactory: ConfiguratorFactoryType) where ConfiguratorFactoryType.HeaderDisplayDataType == HeaderDisplayDataType {
        //type erase
        self.configuratorFactory = AnyHeaderConfiguratorFactory(headerConfiguratorFactory: configuratorFactory)
    }
    
    func register(in tableView: UITableView) {
        
    }
    
    func configuredHeader(in tableView: UITableView, at index: Int, with headerDisplayData: HeaderDisplayDataType) -> UITableViewHeaderFooterView? {
        guard let configurator = configuratorFactory.configurator(with: headerDisplayData) else {
            return nil
        }
        
        let reuseIdentifier = configurator.reuseIdentifier
        
        if registeredIdentifiers.contains(reuseIdentifier) == false {
            registeredIdentifiers.append(reuseIdentifier)
            configurator.register(in: tableView)
        }
        
        return configurator.configuredHeader(in: tableView, at: index, with: headerDisplayData)
    }
}
