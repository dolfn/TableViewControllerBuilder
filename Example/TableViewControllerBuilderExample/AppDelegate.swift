//
//  AppDelegate.swift
//  AnyCellHeadersTableViewTesting
//
//  Created by Corneliu on 10/04/2017.
//  Copyright © 2017 Dolfn. All rights reserved.
//

import UIKit
import TableViewControllerBuilder

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var tableViewModel: ExampleTableViewModel?
    
    func applicationDidFinishLaunching(_ application: UIApplication) {
        
        let tableViewModel = ExampleTableViewModel()
        self.tableViewModel = tableViewModel
        let cellConfiguratorFactory = ExampleCellsConfiguratorFactory()
        let headerConfiguratorFactory = ExampleHeaderConfiguratorFactory()
        
        let tableViewControllerBuilder = TableViewControllerBuilder(viewModel: tableViewModel, cellConfiguratorFactory: cellConfiguratorFactory)
        tableViewControllerBuilder.addHeaders(with: headerConfiguratorFactory, from: tableViewModel)
        
        let tableViewController = tableViewControllerBuilder.buildTableViewController()
        
        let tableViewModelDelegate = tableViewControllerBuilder.buildTableViewModelDelegate()
        tableViewModel.tableViewModelDelegate = tableViewModelDelegate
        tableViewModel.scrollToExampleRow()
        
        window?.rootViewController = tableViewController
    }
}

