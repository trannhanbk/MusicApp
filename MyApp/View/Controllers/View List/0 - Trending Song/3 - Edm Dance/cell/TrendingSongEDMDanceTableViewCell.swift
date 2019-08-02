//
//  TrendingSongEDMDanceTableViewCell.swift
//  MyApp
//
//  Created by Tran Dinh Nhan on 6/15/18.
//  Copyright © 2018 Nhan Tran. All rights reserved.
//

import UIKit

class TrendingSongEDMDanceTableViewCell: UITableViewCell {

    @IBOutlet weak var nameSong: UILabel!
    @IBOutlet weak var imageSongEDM: UIImageView!
    var viewModel: EDMDanceTableCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            configureData(item: viewModel.item)
        }
    }
}

private extension TrendingSongEDMDanceTableViewCell {
    func configureData(item: Item) {
        if let urlThumb = item.image?.first?.url {
            imageSongEDM.sd_setImage(with: URL(string: urlThumb))
            imageSongEDM.layer.cornerRadius = 10
            imageSongEDM.clipsToBounds = true
        }
        nameSong.text = item.name
    }
}

struct EDMDanceTableCellViewModel {
    var item: Item
}
