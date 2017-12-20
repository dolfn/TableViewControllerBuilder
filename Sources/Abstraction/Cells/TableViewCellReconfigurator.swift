//
//  TableViewCellReconfigurator.swift
//  Copyright © 2017 Dolfn. All rights reserved.
//

import Foundation
import UIKit

protocol CellReconfigurator: class {
    func reconfigureCell(in tableView: UITableView, at indexPath: IndexPath)
}
