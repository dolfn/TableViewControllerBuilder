//
//  TableViewModel.swift
//  TableViewControllerBuilder
//
//  Created by Corneliu on 13/04/2017.
//  Copyright © 2017 Dolfn. All rights reserved.
//

import Foundation

public protocol TableViewModel {
    associatedtype HeaderDisplayDataType
    associatedtype CellDisplayDataType
    
    typealias SectionDisplayDataType = AnySectionDisplayData<HeaderDisplayDataType, CellDisplayDataType>
    
    var sectionsDisplayData: [SectionDisplayDataType] { get }
}
