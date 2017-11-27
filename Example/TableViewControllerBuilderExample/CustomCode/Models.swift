//
//  Models.swift
//  AnyCellHeadersTableViewTesting
//
//  Created by Corneliu on 10/04/2017.
//  Copyright © 2017 Dolfn. All rights reserved.
//

import UIKit
import TableViewControllerBuilder

// Cells display data structures
// concrete
struct ComplexCellDisplayData {
    let title: String
    let value: String
    let isRed: Bool
}

//concrete
struct SimpleCellDisplayData {
    let title: String
}

//concrete
enum ExampleCellDisplayDataType {
    case Complex(ComplexCellDisplayData)
    case Simple(SimpleCellDisplayData)
}

extension ExampleCellDisplayDataType: HeightFlexible {
    var estimatedHeight: CGFloat {
        get {
            return self.height
        }
    }
    var height: CGFloat {
        switch self {
        case .Complex: return 60
        case .Simple: return 44
        }
    }
}

// Header data structures
//concrete
struct InteractiveHeaderDisplayData {
    var title: String
    var buttonIcon: String
}

//concrete
struct ColoredHeaderDisplayData {
    var color: UIColor
}
//concrete
enum SectionHeaderType {
    case InteractiveHeader(InteractiveHeaderDisplayData)
    case ColoredHeader(ColoredHeaderDisplayData)
}

extension SectionHeaderType: HeightFlexible {
    var estimatedHeight: CGFloat {
        get {
            return self.height
        }
    }
    var height: CGFloat {
        switch self {
        case .ColoredHeader: return 50
        case .InteractiveHeader: return 30
        }
    }
}

struct ExampleSectionDisplayData: SectionDisplayData {
    typealias HeaderDisplayDataType = SectionHeaderType
    typealias CellDisplayDataType = ExampleCellDisplayDataType
    var headerDisplayData: SectionHeaderType?
    var sectionRowsData: [CellDisplayDataType]
}
