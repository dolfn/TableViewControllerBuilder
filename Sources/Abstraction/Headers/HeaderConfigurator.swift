//
//  HeaderConfigurator.swift
//  Copyright © 2017 Dolfn. All rights reserved.
//

import UIKit

protocol HeaderConfigurator: TableViewRegisterable {
    associatedtype HeaderDisplayDataType
    associatedtype ViewType: UITableViewHeaderFooterView
    
    func configuredHeader(in tableView: UITableView, at index: Int, with headerDisplayData: HeaderDisplayDataType) -> ViewType?
}
