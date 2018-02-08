//
//  HeaderDisplayDataUpdatable.swift
//  Copyright © 2017 Dolfn. All rights reserved.
//

import Foundation

protocol HeaderDisplayDataUpdatable {
    associatedtype HeaderDisplayDataToUpdateWith
    
    func update(headerDisplayData: [HeaderDisplayDataToUpdateWith?])
}
