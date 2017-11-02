//
//  ClosureCellConfigurator.swift
//  TableViewControllerBuilder
//
//  Created by Corneliu on 10/04/2017.
//  Copyright © 2017 Dolfn. All rights reserved.
//

import UIKit

public struct ClosureCellConfigurator<CellDisplayDataType, CellViewType: UITableViewCell>: CellConfigurator {
    
    public typealias CellConfiguration = (CellViewType, CellDisplayDataType) -> ()
    
    let reuseIdentifier: String
    private let configure: CellConfiguration
    
    public init(reuseIdentifier: String = "\(CellViewType.self)", configure: @escaping CellConfiguration) {
        self.reuseIdentifier = reuseIdentifier
        self.configure = configure
    }
    
    func register(in tableView: UITableView) {
        self.registerBasedOnConvention(anyClass: CellViewType.self) {
            switch $0 {
            case .Class(let classRegister):
                tableView.register(classRegister, forCellReuseIdentifier: reuseIdentifier)
            case .Nib(let nibToRegister):
                tableView.register(nibToRegister, forCellReuseIdentifier: reuseIdentifier)
            }
        }
    }
    
    private func dequeReusableCell(tableView: UITableView,
                                   at indexPath: IndexPath) -> CellViewType {
        return tableView.dequeueReusableCell(withIdentifier: reuseIdentifier,
                                             for: indexPath) as! CellViewType
    }
    
    func configuredCell(in tableView: UITableView, at indexPath: IndexPath, with cellDisplayData: CellDisplayDataType) -> CellViewType {
        let cell = dequeReusableCell(tableView: tableView, at: indexPath)
        configure(cell, cellDisplayData)
        return cell
    }
    
    func reconfigureCell(in tableView: UITableView, at indexPath: IndexPath, with cellDisplayData: CellDisplayDataType) {
        guard let cell = tableView.cellForRow(at: indexPath) as? CellViewType else {
            return
        }
        configure(cell, cellDisplayData)
    }
}
