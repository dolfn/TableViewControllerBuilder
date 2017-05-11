//
//  AnyHeaderDisplayDataUpdatable.swift
//  CoMotion
//
//  Created by Corneliu on 25/04/2017.
//  Copyright © 2017 CoMotion. All rights reserved.
//

import Foundation

struct AnyHeaderDisplayDataUpdatable<H>: HeaderDisplayDataUpdatable {
    
    typealias HeaderDisplayDataToUpdateWith = H
    
    private var update: ([H]) -> Void
    
    init<U: HeaderDisplayDataUpdatable>(updatable: U) where U.HeaderDisplayDataToUpdateWith == H {
        update = updatable.update
    }
    
    func update(headerDisplayData: [H]) {
        update(headerDisplayData)
    }
}
