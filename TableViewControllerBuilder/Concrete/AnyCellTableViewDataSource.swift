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
CellConfiguratorType: CellConfigurator>: NSObject, UITableViewDataSource, CellDisplayDataUpdatable where CellConfiguratorType.CellDisplayDataType == RowDisplayDataType {
    
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionDisplayData = sectionsData[indexPath.section]
        let cellData = sectionDisplayData[indexPath.row]
        let cell = cellConfigurator.configuredCell(in: tableView, at: indexPath, with: cellData)
        return cell
    }
}
