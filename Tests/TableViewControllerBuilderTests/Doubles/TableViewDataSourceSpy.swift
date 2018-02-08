//
//  TableViewDataSourceSpy.swift
//  Copyright © 2018 Dolfn. All rights reserved.
//

import Foundation
import UIKit

class TableViewDataSourceSpy: NSObject, UITableViewDataSource {
    
    var didTryToConfigureCell = false
    private let numberOfRowsInFirstSection: Int
    init(numberOfRowsInFirstSection: Int) {
        self.numberOfRowsInFirstSection = numberOfRowsInFirstSection
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRowsInFirstSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        didTryToConfigureCell = true
        return UITableViewCell()
    }
}
