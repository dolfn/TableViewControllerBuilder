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
        tableView.register(CellViewType.self, forCellReuseIdentifier: reuseIdentifier)
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
}
