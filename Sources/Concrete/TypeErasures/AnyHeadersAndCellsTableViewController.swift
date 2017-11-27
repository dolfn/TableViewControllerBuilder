//
//  AnyHeadersAndCellsTableViewController.swift
//  TableViewControllerBuilder
//
//  Created by Corneliu on 10/04/2017.
//  Copyright © 2017 Dolfn. All rights reserved.
//

import UIKit

internal class AnyHeadersAndCellsTableViewController: UIViewController {
    
    internal var tableViewDataSource: UITableViewDataSource? {
        didSet {
            _tableView?.dataSource = tableViewDataSource
            _tableView?.reloadData()
            temporaryStrongTableView?.dataSource = tableViewDataSource
            temporaryStrongTableView?.reloadData()
        }
    }
    internal var tableViewDelegate: UITableViewDelegate? {
        didSet {
            _tableView?.delegate = tableViewDelegate
            _tableView?.reloadData()
            temporaryStrongTableView?.delegate = tableViewDelegate
            temporaryStrongTableView?.reloadData()
        }
    }
    internal var isScrollEnabled: Bool = true {
        didSet {
            _tableView?.isScrollEnabled = isScrollEnabled
            temporaryStrongTableView?.isScrollEnabled = isScrollEnabled
        }
    }
    internal var contentInset: UIEdgeInsets? {
        didSet {
            tryToSetContentInsets()
        }
    }
    internal var backgroundColor: UIColor? {
        didSet {
            view.backgroundColor = backgroundColor
        }
    }
    
    private weak var _tableView: UITableView?
    private var temporaryStrongTableView: UITableView?
    
    internal init() {
        super.init(nibName: nil, bundle: nil)
        temporaryStrongTableView = UITableView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        temporaryStrongTableView = UITableView()
    }
    
    internal override func viewDidLoad() {
        super.viewDidLoad()
        _tableView = temporaryStrongTableView
        
        guard let _tableView = _tableView else {
            return
        }
        tryToSetContentInsets()
        view.backgroundColor = backgroundColor
        _tableView.separatorStyle = .none
        _tableView.dataSource = tableViewDataSource
        _tableView.delegate = tableViewDelegate
        _tableView.estimatedRowHeight = 100
        _tableView.rowHeight = UITableViewAutomaticDimension
        _tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view?.translatesAutoresizingMaskIntoConstraints = false
        view?.addSubview(_tableView)
        let viewsDictionary: [String: Any] = ["tableView": _tableView, "topLayoutGuide": topLayoutGuide]
        let hConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[tableView]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDictionary)
        let vConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:[topLayoutGuide]-0-[tableView]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDictionary)
        view?.addConstraints(hConstraints)
        view?.addConstraints(vConstraints)
        _tableView.reloadData()
    }
    
    internal func getTableView() -> UITableView {
        if let _tableView = _tableView {
            return _tableView
        }
        else {
            return temporaryStrongTableView!
        }
    }
    
    private func tryToSetContentInsets() {
        if let contentInset = contentInset {
            _tableView?.contentInset = contentInset
            temporaryStrongTableView?.contentInset = contentInset
        }
    }
}

