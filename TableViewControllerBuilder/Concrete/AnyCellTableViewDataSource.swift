//
//  AnyCellTableViewDataSource.swift
//  TableViewControllerBuilder
//
//  Created by Corneliu on 10/04/2017.
//  Copyright © 2017 Dolfn. All rights reserved.
//

import UIKit

class AnyTypeOfCellTableViewDataSource<
    RowDisplayDataType,
CellConfiguratorType: CellConfigurator>: NSObject, UITableViewDataSource, CellDisplayDataUpdatable, CellReconfigurator where CellConfiguratorType.CellDisplayDataType == RowDisplayDataType {
    
    typealias CellDisplayDataToUpdateWith = RowDisplayDataType
    
    private var sectionsData = [[RowDisplayDataType]]()
    private let cellConfigurator: CellConfiguratorType
    
    init(rowsConfigurator: CellConfiguratorType) {
        self.cellConfigurator = rowsConfigurator
    }
    
    func updateData(cellsDisplayData: [[RowDisplayDataType]]) {
        self.sectionsData = cellsDisplayData
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionsData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRows = sectionsData[section].count
        return numberOfRows
    }
    
    private func displayData(forItemAt indexPath: IndexPath) -> RowDisplayDataType {
        let sectionDisplayData = sectionsData[indexPath.section]
        let cellData = sectionDisplayData[indexPath.row]
        return cellData
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellData = displayData(forItemAt: indexPath)
        let cell = cellConfigurator.configuredCell(in: tableView, at: indexPath, with: cellData)
        return cell
    }
    
    func reconfigureCell(in tableView: UITableView, at indexPath: IndexPath) {
        let cellData = displayData(forItemAt: indexPath)
        cellConfigurator.reconfigureCell(in: tableView, at: indexPath, with: cellData)
    }
}
