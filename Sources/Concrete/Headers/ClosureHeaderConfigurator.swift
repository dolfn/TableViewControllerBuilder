//
//  ClosureHeaderConfigurator.swift
//  TableViewControllerBuilder
//
//  Created by Corneliu on 10/04/2017.
//  Copyright © 2017 Dolfn. All rights reserved.
//

import UIKit

public struct ClosureHeaderConfigurator<HeaderDisplayDataType, HeaderViewType: UITableViewHeaderFooterView>: HeaderConfigurator {
    
    public typealias HeaderConfigurator = (HeaderDisplayDataType, HeaderViewType) -> ()
    
    let reuseIdentifier: String
    private let headerConfigurator: HeaderConfigurator
    
    public init(reuseIdentifier: String = "\(HeaderViewType.self)", headerConfigurator: @escaping HeaderConfigurator) {
        self.reuseIdentifier = reuseIdentifier
        self.headerConfigurator = headerConfigurator
    }
    
    func register(in tableView: UITableView) {
        self.registerBasedOnConvention(anyClass: HeaderViewType.self) { (registerableClassType: RegisterableClassType) in
            switch registerableClassType {
            case .Nib(let nib):
                tableView.register(nib, forHeaderFooterViewReuseIdentifier: reuseIdentifier)
            case .Class(let classToRegister):
                tableView.register(classToRegister, forHeaderFooterViewReuseIdentifier: reuseIdentifier)
            }
        }
    }
    
    func configuredHeader(in tableView: UITableView, at index: Int, with headerDisplayData: HeaderDisplayDataType) -> HeaderViewType? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: self.reuseIdentifier) as! HeaderViewType
        headerConfigurator(headerDisplayData, headerView)
        return headerView
    }
}
