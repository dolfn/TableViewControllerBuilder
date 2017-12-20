//
//  CellConfigurator.swift
//  Copyright © 2017 Dolfn. All rights reserved.
//

import UIKit

protocol CellConfigurator: TableViewRegisterable {
    associatedtype CellDisplayDataType
    associatedtype CellViewType: UITableViewCell
    
    func configuredCell(in tableView: UITableView, at indexPath: IndexPath, with cellDisplayData: CellDisplayDataType) -> CellViewType
    func reconfigureCell(in tableView: UITableView, at indexPath: IndexPath, with cellDisplayData: CellDisplayDataType)
}
