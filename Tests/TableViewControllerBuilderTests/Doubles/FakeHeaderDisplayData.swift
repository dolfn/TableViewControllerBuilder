//
//  FakeHeaderDisplayData.swift
//  Copyright © 2018 Dolfn. All rights reserved.
//

import Foundation
import UIKit

struct FakeHeaderDisplayData: HeightFlexible {
    var height: CGFloat = 0
    var estimatedHeight: CGFloat = 0
    var identifier = UUID().uuidString
    
    init(height: CGFloat = 0) {
        self.height = height
    }
}

func ==(left: FakeHeaderDisplayData, right: FakeHeaderDisplayData) -> Bool {
    return left.identifier == right.identifier
}

func !=(left: FakeHeaderDisplayData, right: FakeHeaderDisplayData) -> Bool {
    return left.identifier != right.identifier
}

