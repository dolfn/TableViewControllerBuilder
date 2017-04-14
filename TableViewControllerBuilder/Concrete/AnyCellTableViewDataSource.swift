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
CellConfiguratorType: CellConfigurator>: NSObject, UITableViewDataSource where CellConfiguratorType.CellDisplayDataType == RowDisplayDataType {
    
    private let sectionsData: [[RowDisplayDataType]]
    private let cellConfigurator: CellConfiguratorType
    
    init(sectionsData: [[RowDisplayDataType]], rowsConfigurator: CellConfiguratorType) {
        self.sectionsData = sectionsData
        self.cellConfigurator = rowsConfigurator
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
