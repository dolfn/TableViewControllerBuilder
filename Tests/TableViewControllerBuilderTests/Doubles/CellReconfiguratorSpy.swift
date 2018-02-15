//
//  CellReconfiguratorSpy.swift
//  Copyright © 2018 Dolfn. All rights reserved.
//

import Foundation
import UIKit

class CellReconfiguratorSpy: CellReconfigurator {
    
    var indexPath: IndexPath?
    var receivedIndexPaths = [IndexPath]()
    weak var tableView: UITableView?
    
    func reconfigureCell(in tableView: UITableView, at indexPath: IndexPath) {
        self.tableView = tableView
        self.indexPath = indexPath
        receivedIndexPaths.append(indexPath)
    }
    
}
