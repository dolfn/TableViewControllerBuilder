//
//  TableViewCellReconfigurator.swift
//  CoMotion
//
//  Created by Corneliu on 18/05/2017.
//  Copyright © 2017 CoMotion. All rights reserved.
//

import Foundation
import UIKit

protocol CellReconfigurator: class {
    func reconfigureCell(in tableView: UITableView, at indexPath: IndexPath)
}
