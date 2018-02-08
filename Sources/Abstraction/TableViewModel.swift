//
//  TableViewModel.swift
//  Copyright © 2017 Dolfn. All rights reserved.
//

import Foundation
import UIKit

public protocol TableViewModel {
    associatedtype HeaderDisplayDataType
    associatedtype CellDisplayDataType
    
    typealias SectionDisplayDataType = AnySectionDisplayData<HeaderDisplayDataType, CellDisplayDataType>
    var shouldBeScrollable: Bool { get }
    var sectionsDisplayData: [SectionDisplayDataType] { get }
    var edgeInsets: UIEdgeInsets { get }
    var backgroundColor: UIColor? { get }
}
