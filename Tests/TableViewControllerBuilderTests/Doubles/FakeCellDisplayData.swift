//
//  FakeCellDisplayData.swift
//  Copyright © 2018 Dolfn. All rights reserved.
//

import Foundation
import UIKit

struct FakeCellDisplayData: HeightFlexible {
    var height: CGFloat = 0
    var estimatedHeight: CGFloat = 0
    var identifier = UUID().uuidString
    
    init(height: CGFloat = 0, estimatedHeight: CGFloat = 0) {
        self.height = height
        self.estimatedHeight = estimatedHeight
    }
    
    init(height: CGFloat = 0) {
        self.height = height
    }
}

func ==(left: FakeCellDisplayData, right: FakeCellDisplayData) -> Bool {
    return left.identifier == right.identifier
}

func !=(left: FakeCellDisplayData, right: FakeCellDisplayData) -> Bool {
    return left.identifier != right.identifier
}
