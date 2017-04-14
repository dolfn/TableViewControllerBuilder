//
//  HeaderConfigurator.swift
//  TableViewControllerBuilder
//
//  Created by Corneliu on 10/04/2017.
//  Copyright © 2017 Corneliu. All rights reserved.
//

import UIKit

protocol HeaderConfigurator: TableViewRegisterable {
    associatedtype HeaderDisplayDataType
    associatedtype ViewType: UITableViewHeaderFooterView
    
    func configuredHeader(in tableView: UITableView, at index: Int, with headerDisplayData: HeaderDisplayDataType) -> ViewType?
}
