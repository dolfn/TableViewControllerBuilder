//
//  UITableViewSpy.swift
//  Copyright © 2018 Dolfn. All rights reserved.
//

import Foundation
import UIKit

class UITableViewSpy: UITableView {
    
    var shouldReturnCell = true
    var reloadDataCounter: Int = 0
    var sections: IndexSet?
    var animation: UITableViewRowAnimation?
    
    override func cellForRow(at indexPath: IndexPath) -> UITableViewCell? {
        if shouldReturnCell {
            return UITableViewCell()
        }
        return nil
    }
    
    override func reloadData() {
        reloadDataCounter += 1
    }
    
    override func reloadSections(_ sections: IndexSet, with animation: UITableViewRowAnimation) {
        self.sections = sections
        self.animation = animation
    }
    
}
