//
//  TableViewRegisterableExtensions.swift
//  Copyright © 2018 Dolfn. All rights reserved.
//

import Foundation
import UIKit

extension TableViewRegisterable {
    
    typealias RegistrationMethod = (RegisterableClassType) -> Void
    
    func registerBasedOnConvention(anyClass: AnyClass, using registerClosure: RegistrationMethod) {
        let defaultNibName = "\(anyClass)"
        let allBundles = Bundle.allBundles
        let bundleIndexContainingNib = allBundles.index { (bundle: Bundle) -> Bool in
            let path = bundle.path(forResource: defaultNibName, ofType: "nib")
            return path != nil
        }
        if let bundleIndex = bundleIndexContainingNib {
            let bundleAtFoundIndex = allBundles[bundleIndex]
            let headerViewNib = UINib(nibName: defaultNibName, bundle: bundleAtFoundIndex)
            registerClosure(.Nib(headerViewNib))
        }
        else {
            registerClosure(.Class(anyClass))
        }
    }
}
