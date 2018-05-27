//
//  TableViewOperationsManager.swift
//  Copyright © 2017 Dolfn. All rights reserved.
//

import Foundation
import UIKit

class TableViewOperationsManager<H, R: HeightFlexible>: TableViewModelDelegate {
    
    typealias HeaderDisplayDataType = H
    typealias CellDisplayDataType = R
    
    var rowDataUpdatable: AnyCellDisplayDataUpdatable<R>?
    var rowHeightsDataUpdatable: AnyCellDisplayDataUpdatable<R>?
    var headerDataUpdatable: AnyHeaderDisplayDataUpdatable<H>?
    
    weak var tableView: UITableView?
    private weak var cellReconfigurator: CellReconfigurator?
    
    init(cellReconfigurator: CellReconfigurator) {
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
    
    func didUpdateSection(at index: Int, in tableViewModel: AnyTableViewModel<H, R>, animated: Bool) {
        prepareTableView(tableViewModel: tableViewModel, animated: animated) { [weak self] (rowAnimation) in
            let section = IndexSet(integer: index)
            self?.tableView?.reloadSections(section, with: rowAnimation)
        }
    }
    
    func didRemove(itemsFrom indexPaths: [IndexPath], in tableViewModel: AnyTableViewModel<H, R>, animated: Bool) {
        prepareTableView(tableViewModel: tableViewModel, animated: animated) { [weak self] (rowAnimation) in
            self?.tableView?.deleteRows(at: indexPaths, with: rowAnimation)
        }
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
    
    func didReplace(itemsAt indexPaths: [IndexPath], in tableViewModel: AnyTableViewModel<H, R>, animated: Bool) {
        prepareTableView(tableViewModel: tableViewModel, animated: animated) { [weak self] (rowAnimation) in
            self?.tableView?.reloadRows(at: indexPaths, with: rowAnimation)
        }
    }
    
    func didInsertSections(at indexes: [Int], in tableViewModel: AnyTableViewModel<H, R>, animated: Bool) {
        prepareTableView(tableViewModel: tableViewModel, animated: animated) { [weak self] (rowAnimation) in
            let indexSet = NSMutableIndexSet()
            indexes.forEach(indexSet.add)
            self?.tableView?.insertSections(indexSet as IndexSet, with: rowAnimation)
        }
        
    }
    
    func didRemoveSections(at indexes: [Int], in tableViewModel: AnyTableViewModel<H, R>, animated: Bool) {
        prepareTableView(tableViewModel: tableViewModel, animated: animated) { [weak self] (rowAnimation) in
            let indexSet = NSMutableIndexSet()
            indexes.forEach(indexSet.add)
            self?.tableView?.deleteSections(indexSet as IndexSet, with: rowAnimation)
        }
    }
    
    func didUpdateHeights(in tableViewModel: AnyTableViewModelType) {
        updateData(from: tableViewModel)
        tableView?.beginUpdates()
        tableView?.endUpdates()
    }
    
    func didInsert(itemsAt indexPaths: [IndexPath], in tableViewModel: AnyTableViewModel<H, R>, animated: Bool) {
        prepareTableView(tableViewModel: tableViewModel, animated: animated) { [weak self] (rowAnimation) in
            self?.tableView?.insertRows(at: indexPaths, with: rowAnimation)
        }
    }
    
    func scrollTo(indexPath: IndexPath, animated: Bool) {
        tableView?.scrollToRow(at: indexPath, at: .bottom, animated: animated)
    }
    
    private func prepareTableView(tableViewModel: AnyTableViewModel<H, R>, animated: Bool, completion: @escaping (_ rowAnimation: UITableViewRowAnimation) -> Void) {
        updateData(from: tableViewModel)
        let rowAnimation = animated ? UITableViewRowAnimation.automatic : .none
        UIView.setAnimationsEnabled(false)
        tableView?.beginUpdates()
        completion(rowAnimation)
        tableView?.endUpdates()
        UIView.setAnimationsEnabled(true)
    }
    
}
