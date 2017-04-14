//
//  ClosureHeaderConfigurator.swift
//  TableViewControllerBuilder
//
//  Created by Corneliu on 10/04/2017.
//  Copyright © 2017 Dolfn. All rights reserved.
//

import UIKit

public struct ClosureHeaderConfigurator<HeaderDisplayDataType, HeaderViewType: UITableViewHeaderFooterView>: HeaderConfigurator {
    typealias HeaderConfigurator = (HeaderDisplayDataType, HeaderViewType) -> ()
    let reuseIdentifier: String
    private let headerConfigurator: HeaderConfigurator
    init(reuseIdentifier: String = "\(HeaderViewType.self)", headerConfigurator: @escaping HeaderConfigurator) {
        self.reuseIdentifier = reuseIdentifier
        self.headerConfigurator = headerConfigurator
    }
    
    func register(in tableView: UITableView) {
        tableView.register(HeaderViewType.self, forHeaderFooterViewReuseIdentifier: reuseIdentifier)
    }
    
    func configuredHeader(in tableView: UITableView, at index: Int, with headerDisplayData: HeaderDisplayDataType) -> HeaderViewType? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: self.reuseIdentifier) as! HeaderViewType
        headerConfigurator(headerDisplayData, headerView)
        return headerView
    }
}
