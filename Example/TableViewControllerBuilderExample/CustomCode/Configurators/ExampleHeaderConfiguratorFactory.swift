//
//  ExampleHeaderConfiguratorFactory.swift
//  TableViewControllerBuilderExample
//
//  Created by Corneliu on 14/04/2017.
//  Copyright © 2017 Corneliu. All rights reserved.
//

import UIKit
import TableViewControllerBuilder

struct ExampleHeaderConfiguratorFactory: HeaderConfiguratorFactory {
    
    typealias HeaderDisplayDataType = SectionHeaderType
    
    func configurator(with displayDataType: SectionHeaderType) -> AnyHeaderViewConfigurator<SectionHeaderType>? {
        switch displayDataType {
        case .ColoredHeader(let coloredHeaderDisplayData):
            let configurator = ClosureHeaderConfigurator { (headerDisplayData: ColoredHeaderDisplayData, headerView: UITableViewHeaderFooterView) -> () in
                let backgroundView = UIView()
                backgroundView.backgroundColor = headerDisplayData.color
                backgroundView.frame = headerView.bounds
                headerView.backgroundView = backgroundView
            }
            return configurator.erased.with(headerDisplayDataType: coloredHeaderDisplayData)
        case .InteractiveHeader(let interactiveHeaderDisplayData):
            let configurator = ClosureHeaderConfigurator { (headerDisplayData: InteractiveHeaderDisplayData, headerView: ButtonContainerHeaderView) -> () in
                let backgroundView = UIView()
                backgroundView.backgroundColor = UIColor.black
                backgroundView.frame = headerView.bounds
                headerView.backgroundView = backgroundView
                headerView.title?.text = headerDisplayData.title
                headerView.title?.textColor = UIColor.red
                headerView.button?.setTitle(headerDisplayData.buttonIcon, for: .normal)
            }
            return configurator.erased.with(headerDisplayDataType: interactiveHeaderDisplayData)
        }
    }

}
