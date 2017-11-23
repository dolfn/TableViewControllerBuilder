//
//  ButtonContainerHeaderView.swift
//  AnyCellHeadersTableViewTesting
//
//  Created by Corneliu on 10/04/2017.
//  Copyright © 2017 Dolfn. All rights reserved.
//

import UIKit

protocol ButtonContainerHeaderViewDelegate: class {
    func didTapOnRightSideButton(in headerView: ButtonContainerHeaderView)
}

class ButtonContainerHeaderView: UITableViewHeaderFooterView {
    @IBOutlet weak var button: UIButton?
    @IBOutlet weak var title: UILabel?
    weak var delegate: ButtonContainerHeaderViewDelegate?
    
    @IBAction func buttonTapped(button: UIButton) {
        delegate?.didTapOnRightSideButton(in: self)
    }
}
