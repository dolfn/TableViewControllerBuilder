//
//  AnyHeadersAndCellsTableViewController.swift
//  TableViewControllerBuilder
//
//  Created by Corneliu on 10/04/2017.
//  Copyright © 2017 Dolfn. All rights reserved.
//

import UIKit

public class AnyHeadersAndCellsTableViewController: UIViewController {
    
    public var tableViewDataSource: UITableViewDataSource? {
        didSet {
            _tableView?.dataSource = tableViewDataSource
            _tableView?.reloadData()
        }
    }
    public var tableViewDelegate: UITableViewDelegate? {
        didSet {
            _tableView?.delegate = tableViewDelegate
            _tableView?.reloadData()
        }
    }
    
    var tableView: UITableView {
        if let _tableView = _tableView {
            return _tableView
        }
        else {
            let tableViewToAdd = UITableView()
            add(tableView: tableViewToAdd)
            return tableViewToAdd
        }
    }
    private weak var _tableView: UITableView?
    private var temporaryStrongTableView: UITableView?
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        if temporaryStrongTableView != nil {
            _tableView = temporaryStrongTableView
            temporaryStrongTableView = nil
        }
        else {
            let tableView = UITableView()
            add(tableView: tableView)
            temporaryStrongTableView = nil
            _tableView = tableView
        }
        _tableView?.reloadData()
    }
    
    private func add(tableView: UITableView) {
        temporaryStrongTableView = tableView
        tableView.separatorStyle = .none
        tableView.dataSource = tableViewDataSource
        tableView.delegate = tableViewDelegate
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view?.addSubview(tableView)
        let viewsDictionary = ["tableView": tableView]
        let hConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[tableView]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDictionary)
        let vConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[tableView]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDictionary)
        view?.addConstraints(hConstraints)
        view?.addConstraints(vConstraints)
        tableView.reloadData()
    }
}

