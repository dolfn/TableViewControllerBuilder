//
//  UITableViewSpy.swift
//  Copyright © 2018 Dolfn. All rights reserved.
//

import Foundation
import UIKit

class UITableViewSpy: UITableView {
    
    var shouldReturnCell = true
    
    override func cellForRow(at indexPath: IndexPath) -> UITableViewCell? {
        if shouldReturnCell {
            return UITableViewCell()
        }
        return nil
    }
    
}
