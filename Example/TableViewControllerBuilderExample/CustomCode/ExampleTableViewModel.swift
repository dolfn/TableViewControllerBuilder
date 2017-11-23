//
//  ExampleTableViewModel.swift
//  AnyCellHeadersTableViewTesting
//
//  Created by Corneliu on 10/04/2017.
//  Copyright © 2017 Dolfn. All rights reserved.
//

import UIKit
import TableViewControllerBuilder

class ExampleTableViewModel: TableViewModel {
    
    typealias HeaderDisplayDataType = SectionHeaderType
    typealias CellDisplayDataType = ExampleCellDisplayDataType
    
    typealias SectionDisplayDataAlias = AnySectionDisplayData<SectionHeaderType, ExampleCellDisplayDataType>
    
    var sectionsDisplayData: [SectionDisplayDataAlias]
    var shouldBeScrollable = true
    var tableViewModelDelegate: AnyTableViewModelDelegate<SectionHeaderType, ExampleCellDisplayDataType>?
    
    init() {
        sectionsDisplayData = (0...4).map { (sectionIndex) -> SectionDisplayDataAlias in
            let rowsDisplayData = (0...6).map { (rowIndex) -> ExampleCellDisplayDataType in
                if rowIndex % 5 == 0 {
                    return ExampleCellDisplayDataType.Complex(ComplexCellDisplayData(title:"Foo \(rowIndex)", value: "\(rowIndex * 10)", isRed: (rowIndex % 2 == 0)))
                } else {
                    return ExampleCellDisplayDataType.Simple(SimpleCellDisplayData(title:"Bar \(rowIndex)"))
                }
            }
            var headerDisplayData: SectionHeaderType?
            if sectionIndex != 1 {
                if sectionIndex % 2 == 0 {
                    let interactiveHeaderData = InteractiveHeaderDisplayData(title: "Numbers", buttonIcon: "+")
                    headerDisplayData = .InteractiveHeader(interactiveHeaderData)
                }
                else {
                    let coloredHeaderData = ColoredHeaderDisplayData(color: UIColor.red)
                    headerDisplayData = .ColoredHeader(coloredHeaderData)
                }
            }
            let sectionDisplayData = ExampleSectionDisplayData(headerDisplayData: headerDisplayData, sectionRowsData: rowsDisplayData)
            let erasedSectionsDisplayData = AnySectionDisplayData(sectionDisplayData: sectionDisplayData)
            return erasedSectionsDisplayData
        }
    }
    
    func scrollToExampleRow() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {[weak self] in
            let indexPath = IndexPath(row: 3, section: 3)
            self?.tableViewModelDelegate?.scrollTo(indexPath: indexPath, animated: true)
        }
    }
}
