//
//  AnyTableViewModel.swift
//  TableViewControllerBuilder
//
//  Created by Corneliu on 13/04/2017.
//  Copyright © 2017 Dolfn. All rights reserved.
//

import Foundation
import UIKit

public class AnyTableViewModel<H, R>: TableViewModel {
    
    public typealias HeaderDisplayDataType = H
    public typealias RowDisplayDataType = R
    
    public var shouldBeScrollable: Bool {
        get {
            return _shouldBeScrollable
        }
    }
    public var sectionsDisplayData: [AnySectionDisplayData<H, R>] {
        get {
            return _sectionsDisplayData
        }
    }
    
    public var edgeInsets: UIEdgeInsets {
        get {
            return _edgeInsets
        }
    }
    public var backgroundColor: UIColor? {
        get {
            return _backgroundColor
        }
    }
    
    let _sectionsDisplayData: [AnySectionDisplayData<H, R>]
    let _shouldBeScrollable: Bool
    let _edgeInsets: UIEdgeInsets
    let _backgroundColor: UIColor?
    
    init<TableViewModelType: TableViewModel>(tableViewModel: TableViewModelType) where TableViewModelType.HeaderDisplayDataType == H, TableViewModelType.CellDisplayDataType == R {
        _sectionsDisplayData = tableViewModel.sectionsDisplayData
        _shouldBeScrollable = tableViewModel.shouldBeScrollable
        _edgeInsets = tableViewModel.edgeInsets
        _backgroundColor = tableViewModel.backgroundColor
    }
}
