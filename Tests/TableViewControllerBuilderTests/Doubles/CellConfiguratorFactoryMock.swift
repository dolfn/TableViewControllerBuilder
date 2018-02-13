//
//  CellConfiguratorFactoryMock.swift
//  Copyright © 2018 Dolfn. All rights reserved.
//

import Foundation
import UIKit

class CellConfiguratorFactoryMock: CellConfiguratorFactory {
    
    typealias CellDisplayData = FakeCellDisplayData
    
    var numberOfTimesCalledToConfigureRow = 0
    var configurator: ClosureCellConfigurator<FakeCellDisplayData, UITableViewCell>?
    
    func cellConfigurator(with cellDisplayData: FakeCellDisplayData) -> AnyClosureCellConfigurator<FakeCellDisplayData> {
        let configurator = ClosureCellConfigurator {[weak self] (cell: UITableViewCell, data: FakeCellDisplayData) in
            self?.numberOfTimesCalledToConfigureRow += 1
        }
        self.configurator = configurator
        return configurator.erased
    }
}
