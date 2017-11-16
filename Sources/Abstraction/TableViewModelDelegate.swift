//
//  ListViewModelDelegate.swift
//  CoMotion
//
//  Created by Corneliu on 19/04/2017.
//  Copyright © 2017 CoMotion. All rights reserved.
//

import Foundation

public protocol TableViewModelDelegate {
    associatedtype HeaderDisplayDataType
    associatedtype CellDisplayDataType
    
    typealias AnyTableViewModelType = AnyTableViewModel<HeaderDisplayDataType, CellDisplayDataType>

    func didLoadInitialData(in tableViewModel: AnyTableViewModelType)
    func didInsert(itemsAt indexPaths: [IndexPath], in tableViewModel: AnyTableViewModelType, animated: Bool)
    func didInsertSections(at indexes: [Int], in tableViewModel: AnyTableViewModelType, animated: Bool)
    func didRemove(itemsFrom indexPaths: [IndexPath], in tableViewModel: AnyTableViewModelType, animated: Bool)
    func didRemoveSections(at indexes: [Int], in tableViewModel: AnyTableViewModelType)
    func didUpdate(itemsAt indexPaths: [IndexPath], in tableViewModel: AnyTableViewModelType)
    func didReplace(itemsAt indexPaths: [IndexPath], in tableViewModel: AnyTableViewModelType)
    func didUpdateSection(at index: Int, in tableViewModel: AnyTableViewModelType)
    func didUpdateHeights(in tableViewModel: AnyTableViewModelType)
}
