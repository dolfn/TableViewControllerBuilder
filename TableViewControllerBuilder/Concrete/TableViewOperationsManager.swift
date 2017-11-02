//
//  TableViewOperationsManager.swift
//  CoMotion
//
//  Created by Corneliu on 20/04/2017.
//  Copyright © 2017 CoMotion. All rights reserved.
//

import Foundation

class TableViewOperationsManager<H, R: HeightFlexible>: TableViewModelDelegate {
    
    typealias HeaderDisplayDataType = H
    typealias CellDisplayDataType = R
    
    weak var tableView: UITableView?
    weak var cellReconfigurator: CellReconfigurator?
    
    var rowDataUpdatable: AnyCellDisplayDataUpdatable<R>?
    var rowHeightsDataUpdatable: AnyCellDisplayDataUpdatable<R>?
    var headerDataUpdatable: AnyHeaderDisplayDataUpdatable<H>?
    
    init(tableView: UITableView, cellReconfigurator: CellReconfigurator) {
        self.tableView = tableView
        self.cellReconfigurator = cellReconfigurator
    }
    
    private func updateData(from tableViewModel: AnyTableViewModel<H, R>) {
        let cellData = tableViewModel.justCellData
        let headerData = tableViewModel.justHeaderData
        rowDataUpdatable?.updateData(cellsDisplayData: cellData)
        rowHeightsDataUpdatable?.updateData(cellsDisplayData: cellData)
        headerDataUpdatable?.update(headerDisplayData: headerData)
    }
    
    func didLoadInitialData(in tableViewModel: AnyTableViewModel<H, R>) {
        updateData(from: tableViewModel)
        self.tableView?.reloadData()
    }
    
    func didUpdateSection(at index: Int, in tableViewModel: AnyTableViewModel<H, R>) {
        updateData(from: tableViewModel)
        let section = IndexSet(integer: index)
        tableView?.reloadSections(section, with: .automatic)
    }
    
    func didRemove(itemsFrom indexPaths: [IndexPath], in tableViewModel: AnyTableViewModel<H, R>) {
        updateData(from: tableViewModel)
        tableView?.deleteRows(at: indexPaths, with: .automatic)
    }
    
    func didUpdate(itemsAt indexPaths: [IndexPath], in tableViewModel: AnyTableViewModel<H, R>) {
        updateData(from: tableViewModel)
        guard let tableView = tableView else {
            return
        }
        indexPaths.forEach {[weak self] in
            self?.cellReconfigurator?.reconfigureCell(in: tableView, at: $0)
        }
    }
    
    func didReplace(itemsAt indexPaths: [IndexPath], in tableViewModel: AnyTableViewModel<H, R>) {
        updateData(from: tableViewModel)
        self.tableView?.reloadRows(at: indexPaths, with: .automatic)
    }
    
    func didAddSections(at indexes: [Int], in tableViewModel: AnyTableViewModel<H, R>) {
        updateData(from: tableViewModel)
        let indexSet = NSMutableIndexSet()
        indexes.forEach(indexSet.add)
        self.tableView?.insertSections(indexSet as IndexSet, with: .automatic)
    }
    
    func didRemoveSections(at indexes: [Int], in tableViewModel: AnyTableViewModel<H, R>) {
        updateData(from: tableViewModel)
        let indexSet = NSMutableIndexSet()
        indexes.forEach(indexSet.add)
        self.tableView?.deleteSections(indexSet as IndexSet, with: .automatic)
    }
    
    func didUpdateHeights(in tableViewModel: AnyTableViewModelType) {
        updateData(from: tableViewModel)
        tableView?.beginUpdates()
        tableView?.endUpdates()
    }
    
    func didInsert(itemsAt indexPaths: [IndexPath], in tableViewModel: AnyTableViewModel<H, R>) {
        updateData(from: tableViewModel)
        self.tableView?.insertRows(at: indexPaths, with: .automatic)
    }

}
