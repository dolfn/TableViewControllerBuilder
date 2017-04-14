//
//  CellConfigurator.swift
//  TableViewControllerBuilder
//
//  Created by Corneliu on 10/04/2017.
//  Copyright © 2017 Corneliu. All rights reserved.
//

import UIKit

protocol CellConfigurator: TableViewRegisterable {
    associatedtype CellDisplayDataType
    associatedtype CellViewType: UITableViewCell
    
    func configuredCell(in tableView: UITableView, at indexPath: IndexPath, with cellDisplayData: CellDisplayDataType) -> CellViewType
}
