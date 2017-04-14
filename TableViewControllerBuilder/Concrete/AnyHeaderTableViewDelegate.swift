//
//  AnyHeaderTableViewDelegate.swift
//  TableViewControllerBuilder
//
//  Created by Corneliu on 10/04/2017.
//  Copyright © 2017 Dolfn. All rights reserved.
//

import UIKit

class CustomHeightsTableViewCellDelegate<HeaderDisplayDataType: HeightFlexible, HeaderViewConfiguratorType: HeaderConfigurator>: NSObject, UITableViewDelegate where HeaderViewConfiguratorType.HeaderDisplayDataType == HeaderDisplayDataType {
    
    private var headerViewsDisplayData: [HeaderDisplayDataType]
    private var headerViewConfigurator: HeaderViewConfiguratorType
    
    init(headerViewsDisplayData: [HeaderDisplayDataType], headerViewConfigurator: HeaderViewConfiguratorType) {
        self.headerViewsDisplayData = headerViewsDisplayData
        self.headerViewConfigurator = headerViewConfigurator
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerViewDisplayData = headerViewsDisplayData[section]
        let headerView = headerViewConfigurator.configuredHeader(in: tableView, at: section, with: headerViewDisplayData)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let height = headerViewsDisplayData[section].height
        return CGFloat(height)
    }
}
