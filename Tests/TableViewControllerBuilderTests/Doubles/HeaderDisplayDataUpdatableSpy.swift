//
//  HeaderDisplayDataUpdatableSpy.swift
//  Copyright © 2018 Dolfn. All rights reserved.
//

import Foundation

class HeaderDisplayDataUpdatableSpy: HeaderDisplayDataUpdatable {
    
    typealias HeaderDisplayDataToUpdateWith = FakeHeaderDisplayData
    
    var headerDisplayData: [FakeHeaderDisplayData?]?
    
    func update(headerDisplayData: [FakeHeaderDisplayData?]) {
        self.headerDisplayData = headerDisplayData
    }
}
