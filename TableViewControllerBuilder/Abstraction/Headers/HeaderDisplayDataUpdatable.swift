//
//  HeaderDisplayDataUpdatable.swift
//  CoMotion
//
//  Created by Corneliu on 25/04/2017.
//  Copyright © 2017 CoMotion. All rights reserved.
//

import Foundation

protocol HeaderDisplayDataUpdatable {
    associatedtype HeaderDisplayDataToUpdateWith
    func update(headerDisplayData: [HeaderDisplayDataToUpdateWith])
}
