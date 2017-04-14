//
//  AnyClosureCellConfigurator.swift
//  TableViewControllerBuilder
//
//  Created by Corneliu on 10/04/2017.
//  Copyright © 2017 Dolfn. All rights reserved.
//

import UIKit

public struct AnyClosureCellConfigurator<CellDisplayDataType>: CellConfigurator {
    let reuseIdentifier: String
    
    typealias RegisterClosureType = (UITableView) -> ()
    typealias ConfigureClosureType = (UITableView, IndexPath, CellDisplayDataType) -> UITableViewCell
    
    private let _register: RegisterClosureType
    private let _configure: ConfigureClosureType
    
    init<CellViewType>(base: ClosureCellConfigurator<CellDisplayDataType, CellViewType>) {
        _register = base.register
        _configure = base.configuredCell
        reuseIdentifier = base.reuseIdentifier
    }
    
    private init(register: @escaping RegisterClosureType,
                 reuseIdentifier: String,
                 configure: @escaping ConfigureClosureType) {
        _register = register
        _configure = configure
        self.reuseIdentifier = reuseIdentifier
    }
    
    func register(in tableView: UITableView) {
        _register(tableView)
    }
    
    func configuredCell(in tableView: UITableView, at indexPath: IndexPath, with cellDisplayData: CellDisplayDataType) -> UITableViewCell {
        return _configure(tableView, indexPath, cellDisplayData)
    }
    
    public func with<U>(cellDisplayData: CellDisplayDataType) -> AnyClosureCellConfigurator<U> {
        return AnyClosureCellConfigurator<U>(register: _register,
                                             reuseIdentifier: reuseIdentifier,
                                             configure: { (tableView:UITableView, indexPath:IndexPath, _) -> UITableViewCell in
                                                self._configure(tableView, indexPath, cellDisplayData)
        })
    }
}
