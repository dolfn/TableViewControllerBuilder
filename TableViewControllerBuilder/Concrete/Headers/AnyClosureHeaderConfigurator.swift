//
//  AnyClosureHeaderConfigurator.swift
//  TableViewControllerBuilder
//
//  Created by Corneliu on 10/04/2017.
//  Copyright © 2017 Corneliu. All rights reserved.
//

import UIKit

public struct AnyHeaderViewConfigurator<HeaderDisplayDataType>: HeaderConfigurator {
    
    typealias RegisterClosureType = (UITableView) -> ()
    typealias ConfigureClosureType = (UITableView, Int, HeaderDisplayDataType) -> UITableViewHeaderFooterView?
    
    private let register: RegisterClosureType
    private let configure: ConfigureClosureType
    let reuseIdentifier: String
    
    init<HeaderViewType>(baseConfigurator: ClosureHeaderConfigurator<HeaderDisplayDataType, HeaderViewType>) {
        register = baseConfigurator.register
        configure = baseConfigurator.configuredHeader
        reuseIdentifier = "\(HeaderViewType.self)"
    }
    
    private init(reuseIdentifier: String, register: @escaping RegisterClosureType, configure: @escaping ConfigureClosureType) {
        self.reuseIdentifier = reuseIdentifier
        self.register = register
        self.configure = configure
    }
    
    func register(in tableView: UITableView) {
        register(tableView)
    }
    
    func configuredHeader(in tableView: UITableView, at index: Int, with headerDisplayData: HeaderDisplayDataType) -> UITableViewHeaderFooterView? {
        return configure(tableView, index, headerDisplayData)
    }
    
    func with<T>(headerDisplayDataType: HeaderDisplayDataType) -> AnyHeaderViewConfigurator<T> {
        let erasedTypeObject = AnyHeaderViewConfigurator<T>(reuseIdentifier: reuseIdentifier, register: register) { (tableView: UITableView, index: Int, _) -> UITableViewHeaderFooterView? in
            return self.configure(tableView, index, headerDisplayDataType)
        }
        return erasedTypeObject
    }
}
