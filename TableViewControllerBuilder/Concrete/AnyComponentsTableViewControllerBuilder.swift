//
//  TableViewControllerBuilder.swift
//  TableViewControllerBuilder
//
//  Created by Corneliu on 13/04/2017.
//  Copyright © 2017 Dolfn. All rights reserved.
//

import Foundation

public class TableViewControllerBuilder<HeaderDisplayDataType, CellDisplayDataType> {
    
    private var viewModel: AnyTableViewModel<HeaderDisplayDataType, CellDisplayDataType>
    private var cellConfiguratorSelector: CellConfiguratorSelector<CellDisplayDataType>
    
    public init<TableViewModelType: TableViewModel, RowConfiguratorFactoryType:CellConfiguratorFactory>(viewModel: TableViewModelType, cellConfiguratorFactory: RowConfiguratorFactoryType) where TableViewModelType.HeaderDisplayDataType == HeaderDisplayDataType, TableViewModelType.CellDisplayDataType == CellDisplayDataType, RowConfiguratorFactoryType.CellDisplayData == CellDisplayDataType {
        self.viewModel = AnyTableViewModel(tableViewModel: viewModel)
        let cellConfiguratorSelector = CellConfiguratorSelector(configuratorFactory: cellConfiguratorFactory)
        self.cellConfiguratorSelector = cellConfiguratorSelector
    }
    
    public var tableViewController: UIViewController {
        get {
            let justTheRowsInSections = self.viewModel.sectionsDisplayData.map { (sectionDisplayData) -> [CellDisplayDataType] in
                return sectionDisplayData.sectionRowsData
            }
            
//            let justTheHeadersInSections = viewModel.sectionsDisplayData.map { (sectionDisplayData) -> HeaderDisplayDataType in
//                return sectionDisplayData.headerDisplayData
//            }
            
            let tableViewDataSource = AnyTypeOfCellTableViewDataSource(sectionsData: justTheRowsInSections, rowsConfigurator: cellConfiguratorSelector)
            
//            let tableViewDelegate = CustomHeightsTableViewCellDelegate(headerViewsDisplayData: justTheHeadersInSections, headerViewConfigurator: headerConfiguratorSelector)
            
            let tableViewController = AnyHeadersAndCellsTableViewController()
//            tableViewController.tableViewDelegate = tableViewDelegate
            tableViewController.tableViewDataSource = tableViewDataSource
            return tableViewController
        }
    }
}
