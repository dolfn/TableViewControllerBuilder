//
//  SectionDisplayDataExtensions.swift
//  Copyright © 2018 Dolfn. All rights reserved.
//

import Foundation

extension SectionDisplayData {
    public var erased: AnySectionDisplayData<HeaderDisplayDataType, CellDisplayDataType> {
        get {
            return AnySectionDisplayData(sectionDisplayData: self)
        }
    }
}
