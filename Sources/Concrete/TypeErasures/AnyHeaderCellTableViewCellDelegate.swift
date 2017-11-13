//
//  AnyHeaderCellTableViewCellDelegate.swift
//  TableViewControllerBuilder
//
//  Created by Corneliu on 10/04/2017.
//  Copyright © 2017 Dolfn. All rights reserved.
//

import UIKit

class AnyHeaderCellTableViewCellDelegate<HeaderDisplayDataType: HeightFlexible, CellDisplayData: HeightFlexible, HeaderViewConfiguratorType: HeaderConfigurator>: NSObject, UITableViewDelegate, CellDisplayDataUpdatable, HeaderDisplayDataUpdatable where HeaderViewConfiguratorType.HeaderDisplayDataType == HeaderDisplayDataType {
    
    typealias CellDisplayDataToUpdateWith = CellDisplayData
    typealias HeaderDisplayDataToUpdateWith = HeaderDisplayDataType
    
    private var rowHeightProviders: [[CellDisplayData]]
    private var headerViewsDisplayData: [HeaderDisplayDataType?]
    private var headerViewConfigurator: HeaderViewConfiguratorType?
    var actionsDelegate: AnyCellEventsDelegate<CellDisplayData>?
    
    init(rowHeightProviders: [[CellDisplayData]],
         headerViewsDisplayData: [HeaderDisplayDataType?]) {
        self.rowHeightProviders = rowHeightProviders
        self.headerViewsDisplayData = headerViewsDisplayData
    }
    
    func addHeaderConfigurator(headerViewConfigurator: HeaderViewConfiguratorType) {
        self.headerViewConfigurator = headerViewConfigurator
    }
    
    func updateData(cellsDisplayData: [[CellDisplayData]]) {
        rowHeightProviders = cellsDisplayData
    }
    
    func update(headerDisplayData: [HeaderDisplayDataType?]) {
        headerViewsDisplayData = headerDisplayData
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let headerViewConfigurator = headerViewConfigurator,
            section < headerViewsDisplayData.count,
            let headerViewDisplayData = headerViewsDisplayData[section] {
            let headerView = headerViewConfigurator.configuredHeader(in: tableView, at: section, with: headerViewDisplayData)
            return headerView
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if let _ = headerViewConfigurator,
            section < headerViewsDisplayData.count,
            let headerDisplayData = headerViewsDisplayData[section] {
            let height = headerDisplayData.height
            return CGFloat(height)
        }
        return 0.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let rowHeightProviderInSection = rowHeightProviders[indexPath.section]
        let rowHeightProvider = rowHeightProviderInSection[indexPath.row]
        return CGFloat(rowHeightProvider.height)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rowHeightProviderInSection = rowHeightProviders[indexPath.section]
        let displayData = rowHeightProviderInSection[indexPath.row]
        actionsDelegate?.didSelect(cellWith: displayData)
    }
}
