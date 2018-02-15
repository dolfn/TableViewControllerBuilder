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
    var deleteRowsIndexPaths = [IndexPath]()
    var reloadRowsIndexPaths = [IndexPath]()
    var insertedRowsIndexPaths = [IndexPath]()
    var insertedSections: IndexSet?
    var deletedSections: IndexSet?
    var beginUpdatesCalled = false
    var endUpdatesCalled = false
    var scrollToIndexPath: IndexPath?
    var scrollPosition: UITableViewScrollPosition?
    var animated: Bool?
    
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
    
    override func deleteRows(at indexPaths: [IndexPath], with animation: UITableViewRowAnimation) {
        self.deleteRowsIndexPaths = indexPaths
        self.animation = animation
    }
    
    override func reloadRows(at indexPaths: [IndexPath], with animation: UITableViewRowAnimation) {
        self.reloadRowsIndexPaths = indexPaths
        self.animation = animation
    }
    
    override func insertSections(_ sections: IndexSet, with animation: UITableViewRowAnimation) {
        insertedSections = sections
        self.animation = animation
    }
    
    override func deleteSections(_ sections: IndexSet, with animation: UITableViewRowAnimation) {
        deletedSections = sections
        self.animation = animation
    }
    
    override func insertRows(at indexPaths: [IndexPath], with animation: UITableViewRowAnimation) {
        insertedRowsIndexPaths = indexPaths
        self.animation = animation
    }
    
    override func beginUpdates() {
        beginUpdatesCalled = true
    }
    
    override func endUpdates() {
        endUpdatesCalled = true
    }
    
    override func scrollToRow(at indexPath: IndexPath, at scrollPosition: UITableViewScrollPosition, animated: Bool) {
        scrollToIndexPath = indexPath
        self.scrollPosition = scrollPosition
        self.animated = animated
    }
}
