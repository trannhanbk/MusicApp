//
//  SideMenuTableViewCell.swift
//  MyApp
//
//  Created by Tran Dinh Nhan on 5/27/18.
//  Copyright © 2018 Nhan Tran. All rights reserved.
//

import UIKit

class SideMenuTableViewCell: UITableViewCell {

    @IBOutlet fileprivate weak var titleLabel: UILabel!
    // MARK: - Properties
    var viewModel: SideMenuCellViewModel? {
        didSet {
            updateView()
        }
    }

    func updateView() {
        guard let viewModel = viewModel else { return }
        titleLabel.text = viewModel.title
        titleLabel.textColor = UIColor.black
    }
}
