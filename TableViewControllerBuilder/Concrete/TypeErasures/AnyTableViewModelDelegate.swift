//
//  AnyTableViewModelDelegate.swift
//  CoMotion
//
//  Created by Corneliu on 25/04/2017.
//  Copyright © 2017 CoMotion. All rights reserved.
//

import Foundation

public struct AnyTableViewModelDelegate<H, R>: TableViewModelDelegate {
    
    public typealias HeaderDisplayDataType = H
    public typealias CellDisplayDataType = R
    
    private var didLoadInitialData: (AnyTableViewModel<H, R>) -> Void
    private var didUpdate: ([IndexPath], AnyTableViewModel<H, R>) -> Void
    private var didReplace: ([IndexPath], AnyTableViewModel<H, R>) -> Void
    private var didRemove: ([IndexPath], AnyTableViewModel<H, R>) -> Void
    private var didAddSections: ([Int], AnyTableViewModel<H, R>) -> Void
    private var didRemoveSections: ([Int], AnyTableViewModel<H, R>) -> Void
    private var didUpdateSection: (Int, AnyTableViewModel<H, R>) -> Void
    private var didUpdateHeights: (AnyTableViewModel<H, R>) -> Void
    private var didInsert: ([IndexPath], AnyTableViewModel<H, R>) -> Void
    
    init<D: TableViewModelDelegate>(delegate: D) where D.HeaderDisplayDataType == H, D.CellDisplayDataType == R {
        didLoadInitialData = delegate.didLoadInitialData
        didUpdate = delegate.didUpdate
        didReplace = delegate.didReplace
        didRemove = delegate.didRemove
        didUpdateSection = delegate.didUpdateSection
        didAddSections = delegate.didAddSections
        didRemoveSections = delegate.didRemoveSections
        didUpdateHeights = delegate.didUpdateHeights
        didInsert = delegate.didInsert
    }
    
    public func didUpdateHeights(in tableViewModel: AnyTableViewModel<H, R>) {
        didUpdateHeights(tableViewModel)
    }
    
    public func didLoadInitialData(in tableViewModel: AnyTableViewModel<H, R>) {
        didLoadInitialData(tableViewModel)
    }
        
    public func didUpdate(itemsAt indexPaths: [IndexPath], in tableViewModel: AnyTableViewModel<H, R>) {
        didUpdate(indexPaths, tableViewModel)
    }
    
    public func didReplace(itemsAt indexPaths: [IndexPath], in tableViewModel: AnyTableViewModel<H, R>) {
        didReplace(indexPaths, tableViewModel)
    }
    
    public func didUpdateSection(at index: Int, in tableViewModel: AnyTableViewModel<H, R>) {
        didUpdateSection(index, tableViewModel)
    }
    
    public func didRemove(itemsFrom indexPaths: [IndexPath], in tableViewModel: AnyTableViewModel<H, R>) {
        didRemove(indexPaths, tableViewModel)
    }

    public func didAddSections(at indexes: [Int], in tableViewModel: AnyTableViewModel<H, R>) {
        didAddSections(indexes, tableViewModel)
    }
    
    public func didRemoveSections(at indexes: [Int], in tableViewModel: AnyTableViewModel<H, R>) {
        didRemoveSections(indexes, tableViewModel)
    }
    
    public func didInsert(itemsAt indexPaths: [IndexPath], in tableViewModel: AnyTableViewModel<H, R>) {
        didInsert(indexPaths, tableViewModel)
    }
    
}
