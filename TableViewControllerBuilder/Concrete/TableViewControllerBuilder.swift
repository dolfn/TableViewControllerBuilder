//
//  TableViewControllerBuilder.swift
//  TableViewControllerBuilder
//
//  Created by Corneliu on 13/04/2017.
//  Copyright © 2017 Dolfn. All rights reserved.
//

import Foundation

public class TableViewControllerBuilder<HeaderDisplayDataType: HeightFlexible, CellDisplayDataType: HeightFlexible> {
    
    private var viewModel: AnyTableViewModel<HeaderDisplayDataType, CellDisplayDataType>
    private var headerConfiguratorSelector: HeaderViewConfiguratorSelector<HeaderDisplayDataType>?
    private var cellConfiguratorSelector: CellConfiguratorSelector<CellDisplayDataType>
    
    private weak var usingTableViewController:AnyHeadersAndCellsTableViewController?
    private var tableViewOperationsManager: TableViewOperationsManager<HeaderDisplayDataType, CellDisplayDataType>?
    private var anyTypeOfCellTableViewDataSource: AnyTypeOfCellTableViewDataSource<CellDisplayDataType, CellConfiguratorSelector<CellDisplayDataType>>?
    private var anyHeaderCellTableViewCellDelegate: AnyHeaderCellTableViewCellDelegate<HeaderDisplayDataType, CellDisplayDataType, HeaderViewConfiguratorSelector<HeaderDisplayDataType>>?
    private var eventsHandler: AnyCellEventsDelegate<CellDisplayDataType>?
    
    public init<TableViewModelType: TableViewModel, RowConfiguratorFactoryType:CellConfiguratorFactory>(viewModel: TableViewModelType, cellConfiguratorFactory: RowConfiguratorFactoryType) where TableViewModelType.HeaderDisplayDataType == HeaderDisplayDataType, TableViewModelType.CellDisplayDataType == CellDisplayDataType, RowConfiguratorFactoryType.CellDisplayData == CellDisplayDataType {
        
        self.viewModel = AnyTableViewModel(tableViewModel: viewModel)
        let cellConfiguratorSelector = CellConfiguratorSelector(configuratorFactory: cellConfiguratorFactory)
        self.cellConfiguratorSelector = cellConfiguratorSelector
    }
    
    public func buildTableViewController() -> UIViewController {
        if let alreadyCreatedTableViewController = usingTableViewController {
            return alreadyCreatedTableViewController
        }
        
        let tableViewController = AnyHeadersAndCellsTableViewController()
        usingTableViewController = tableViewController
        
        tableViewController.tableView.isScrollEnabled = viewModel.shouldBeScrollable
        
        let tableViewDataSource = AnyTypeOfCellTableViewDataSource(rowsConfigurator: cellConfiguratorSelector)
        tableViewDataSource.updateData(cellsDisplayData: viewModel.justCellData)
        anyTypeOfCellTableViewDataSource = tableViewDataSource
        
        if let tableViewOperationsManager = tableViewOperationsManager {
            addRowDataUpdatables(for: tableViewOperationsManager, updatable: tableViewDataSource)
        }
        
        tableViewController.tableViewDataSource = tableViewDataSource
        
        addHeadersInViewControllerIfNecessary()
        
        return tableViewController
    }
    
    public func buildTableViewModelDelegate() -> AnyTableViewModelDelegate<HeaderDisplayDataType, CellDisplayDataType>? {
        if let anyTypeOfCellTableViewDataSource = anyTypeOfCellTableViewDataSource,
            let usingTableViewController = usingTableViewController {
            let tableView = usingTableViewController.tableView
            let tableViewOperationsManager = TableViewOperationsManager<HeaderDisplayDataType, CellDisplayDataType>(tableView: tableView, cellReconfigurator: anyTypeOfCellTableViewDataSource)
            self.tableViewOperationsManager = tableViewOperationsManager
            addRowDataUpdatables(for: tableViewOperationsManager, updatable: anyTypeOfCellTableViewDataSource)
            
            if let anyHeaderCellTableViewCellDelegate = anyHeaderCellTableViewCellDelegate {
                addRowHeightsUpdatables(for: tableViewOperationsManager, updatable: anyHeaderCellTableViewCellDelegate)
            }
            if let anyHeaderCellTableViewCellDelegate = anyHeaderCellTableViewCellDelegate {
                addHeaderDataUpdatables(for: tableViewOperationsManager, updatable: anyHeaderCellTableViewCellDelegate)
            }
            let erasedTableViewDelegate = AnyTableViewModelDelegate(delegate: tableViewOperationsManager)
            return erasedTableViewDelegate
        }
        
        return nil
    }
    
    public func addHeaders<HeaderConfiguratorFactoryType: HeaderConfiguratorFactory>(with headerConfiguratorFactory: HeaderConfiguratorFactoryType) where HeaderConfiguratorFactoryType.HeaderDisplayDataType == HeaderDisplayDataType {
        headerConfiguratorSelector = HeaderViewConfiguratorSelector(configuratorFactory: headerConfiguratorFactory)
        addHeadersInViewControllerIfNecessary()
    }
    
    public func addEventsHandler<EventsHandlerType: CellEventsDelegate>(handler: EventsHandlerType) where EventsHandlerType.CellDisplayDataType == CellDisplayDataType {
        let erasedEventsHandler = AnyCellEventsDelegate(delegate: handler)
        self.eventsHandler = erasedEventsHandler
        anyHeaderCellTableViewCellDelegate?.actionsDelegate = erasedEventsHandler
    }
    
    private func addHeadersInViewControllerIfNecessary() {
        let headerData = self.viewModel.justHeaderData
        let anyHeaderCellTableViewCellDelegate = AnyHeaderCellTableViewCellDelegate<HeaderDisplayDataType, CellDisplayDataType, HeaderViewConfiguratorSelector<HeaderDisplayDataType>>(rowHeightProviders: self.viewModel.justCellData, headerViewsDisplayData: headerData)
        anyHeaderCellTableViewCellDelegate.actionsDelegate = self.eventsHandler
        self.anyHeaderCellTableViewCellDelegate = anyHeaderCellTableViewCellDelegate
        usingTableViewController?.tableViewDelegate = anyHeaderCellTableViewCellDelegate
        
        if let headerConfiguratorSelector = headerConfiguratorSelector {
            anyHeaderCellTableViewCellDelegate.addHeaderConfigurator(headerViewConfigurator: headerConfiguratorSelector)
        }
        
        if let tableViewOperationsManager = tableViewOperationsManager {
            addRowHeightsUpdatables(for: tableViewOperationsManager, updatable: anyHeaderCellTableViewCellDelegate)
            addHeaderDataUpdatables(for: tableViewOperationsManager, updatable: anyHeaderCellTableViewCellDelegate)
        }
    }
    
    
    private func addRowDataUpdatables<CU: CellDisplayDataUpdatable>(for tableViewOperationsManager: TableViewOperationsManager<HeaderDisplayDataType, CellDisplayDataType>, updatable: CU) where CU.CellDisplayDataToUpdateWith == CellDisplayDataType {
        let rowDataUpdatable = AnyCellDisplayDataUpdatable(updatable: updatable)
        tableViewOperationsManager.rowDataUpdatable = rowDataUpdatable
    }
    
    private func addRowHeightsUpdatables<CU: CellDisplayDataUpdatable>(for tableViewOperationsManager: TableViewOperationsManager<HeaderDisplayDataType, CellDisplayDataType>, updatable: CU) where CU.CellDisplayDataToUpdateWith == CellDisplayDataType {
        let rowHeightsUpdatable = AnyCellDisplayDataUpdatable(updatable: updatable)
        tableViewOperationsManager.rowHeightsDataUpdatable = rowHeightsUpdatable
    }
    
    private func addHeaderDataUpdatables<HU: HeaderDisplayDataUpdatable>(for tableViewOperationsManager: TableViewOperationsManager<HeaderDisplayDataType, CellDisplayDataType>, updatable: HU) where HU.HeaderDisplayDataToUpdateWith == HeaderDisplayDataType {
        let headerDataUpdatable = AnyHeaderDisplayDataUpdatable(updatable: updatable)
        tableViewOperationsManager.headerDataUpdatable = headerDataUpdatable
    }
}
