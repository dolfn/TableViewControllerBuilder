//
//  TableViewControllerBuilder.swift
//  TableViewControllerBuilder
//
//  Created by Corneliu on 13/04/2017.
//  Copyright © 2017 Dolfn. All rights reserved.
//

import Foundation

public class TableViewControllerBuilder<HeaderDisplayDataType: HeightFlexible, CellDisplayDataType> {
    
    private var viewModel: AnyTableViewModel<HeaderDisplayDataType, CellDisplayDataType>
    private var headerConfiguratorSelector: HeaderViewConfiguratorSelector<HeaderDisplayDataType>?
    private var cellConfiguratorSelector: CellConfiguratorSelector<CellDisplayDataType>
    
    public init<TableViewModelType: TableViewModel, RowConfiguratorFactoryType:CellConfiguratorFactory>(viewModel: TableViewModelType, cellConfiguratorFactory: RowConfiguratorFactoryType) where TableViewModelType.HeaderDisplayDataType == HeaderDisplayDataType, TableViewModelType.CellDisplayDataType == CellDisplayDataType, RowConfiguratorFactoryType.CellDisplayData == CellDisplayDataType {
        
        self.viewModel = AnyTableViewModel(tableViewModel: viewModel)
        let cellConfiguratorSelector = CellConfiguratorSelector(configuratorFactory: cellConfiguratorFactory)
        self.cellConfiguratorSelector = cellConfiguratorSelector
    }
    
    public func addHeaders<HeaderConfiguratorFactoryType: HeaderConfiguratorFactory>(with headerConfiguratorFactory: HeaderConfiguratorFactoryType) where HeaderConfiguratorFactoryType.HeaderDisplayDataType == HeaderDisplayDataType {
        self.headerConfiguratorSelector = HeaderViewConfiguratorSelector(configuratorFactory: headerConfiguratorFactory)
    }
    
    public var tableViewController: UIViewController {
        get {
            let justTheRowsInSections = self.viewModel.sectionsDisplayData.map { (sectionDisplayData) -> [CellDisplayDataType] in
                return sectionDisplayData.sectionRowsData
            }
            
            let justTheHeadersInSections = viewModel.sectionsDisplayData.map { (sectionDisplayData) -> HeaderDisplayDataType in
                return sectionDisplayData.headerDisplayData
            }
            
            let tableViewDataSource = AnyTypeOfCellTableViewDataSource(sectionsData: justTheRowsInSections, rowsConfigurator: cellConfiguratorSelector)
            
            let tableViewController = AnyHeadersAndCellsTableViewController()
            tableViewController.tableViewDataSource = tableViewDataSource
            
            if let headerConfiguratorSelector = headerConfiguratorSelector {
                let tableViewDelegate = CustomHeightsTableViewCellDelegate(headerViewsDisplayData: justTheHeadersInSections, headerViewConfigurator: headerConfiguratorSelector)
                tableViewController.tableViewDelegate = tableViewDelegate
            }
            
            return tableViewController
        }
    }
}
