//
//  TitleSubtitleTableViewCell.swift
//  AnyCellHeadersTableViewTesting
//
//  Created by Corneliu on 10/04/2017.
//  Copyright © 2017 Dolfn. All rights reserved.
//

import UIKit

protocol TitleSubtitleTableViewCellDelegate: class {
    func tappedOn(rightSideButtonIn cell: TitleSubtitleTableViewCell)
}

class TitleSubtitleTableViewCell: UITableViewCell {
    @IBOutlet weak var title: UILabel?
    @IBOutlet weak var subtitle: UILabel?
    weak var delegate: TitleSubtitleTableViewCellDelegate?
    
    @IBAction func tappedOnRightSideButton(button: UIButton) {
        delegate?.tappedOn(rightSideButtonIn: self)
    }
}
