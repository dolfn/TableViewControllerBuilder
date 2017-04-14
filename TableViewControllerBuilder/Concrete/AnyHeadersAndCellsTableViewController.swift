//
//  AnyHeadersAndCellsTableViewController.swift
//  TableViewControllerBuilder
//
//  Created by Corneliu on 10/04/2017.
//  Copyright © 2017 Dolfn. All rights reserved.
//

import UIKit

public class AnyHeadersAndCellsTableViewController: UITableViewController {
    
    public var tableViewDataSource: UITableViewDataSource? {
        didSet {
            tableView.dataSource = tableViewDataSource
            tableView.reloadData()
        }
    }
    public var tableViewDelegate: UITableViewDelegate? {
        didSet {
            tableView.delegate = tableViewDelegate
            tableView.reloadData()
        }
    }
    
    public init() {
        super.init(style: UITableViewStyle.plain)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = tableViewDataSource
        tableView.delegate = tableViewDelegate
    }
    
}

