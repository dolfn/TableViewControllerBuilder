//
//  AnyClosureCellConfigurator.swift
//  Copyright © 2017 Dolfn. All rights reserved.
//

import UIKit

public struct AnyClosureCellConfigurator<CellDisplayDataType>: CellConfigurator {
    let reuseIdentifier: String
    
    typealias RegisterClosureType = (UITableView) -> ()
    typealias ConfigureClosureType = (UITableView, IndexPath, CellDisplayDataType) -> UITableViewCell
    typealias ReconfigureClosureType = (UITableView, IndexPath, CellDisplayDataType) -> Void
    
    private let _register: RegisterClosureType
    private let _configure: ConfigureClosureType
    private let _reconfigure: ReconfigureClosureType
    
    init<CellViewType>(base: ClosureCellConfigurator<CellDisplayDataType, CellViewType>) {
        _register = base.register
        _configure = base.configuredCell
        _reconfigure = base.reconfigureCell
        reuseIdentifier = base.reuseIdentifier
    }
    
    private init(register: @escaping RegisterClosureType,
                 reuseIdentifier: String,
                 configure: @escaping ConfigureClosureType,
                 reconfigure: @escaping ReconfigureClosureType) {
        _register = register
        _configure = configure
        _reconfigure = reconfigure
        self.reuseIdentifier = reuseIdentifier
    }
    
    public func with<U>(cellDisplayData: CellDisplayDataType) -> AnyClosureCellConfigurator<U> {
        return AnyClosureCellConfigurator<U>(register: _register,
                                             reuseIdentifier: reuseIdentifier,
                                             configure: { (tableView:UITableView, indexPath:IndexPath, _) -> UITableViewCell in
                                                self._configure(tableView, indexPath, cellDisplayData)
        }, reconfigure: { (tableView:UITableView, indexPath:IndexPath, _) -> Void in
            self._reconfigure(tableView, indexPath, cellDisplayData)
        })
    }
    
    func register(in tableView: UITableView) {
        _register(tableView)
    }
    
    func configuredCell(in tableView: UITableView, at indexPath: IndexPath, with cellDisplayData: CellDisplayDataType) -> UITableViewCell {
        return _configure(tableView, indexPath, cellDisplayData)
    }
    
    func reconfigureCell(in tableView: UITableView, at indexPath: IndexPath, with cellDisplayData: CellDisplayDataType) {
        _reconfigure(tableView, indexPath, cellDisplayData)
    }
    
}
