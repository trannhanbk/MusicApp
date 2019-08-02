//
//  JazzMusicTableViewCell.swift
//  MyApp
//
//  Created by Tran Dinh Nhan on 6/18/18.
//  Copyright © 2018 Nhan Tran. All rights reserved.
//

import UIKit

class JazzMusicTableViewCell: UITableViewCell {

    @IBOutlet private weak var imageSong: UIImageView!
    @IBOutlet private weak var nameSong: UILabel!

    var viewModel: JazzMusicTableViewCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            configureData(item: viewModel.item)
        }
    }

    func configureData(item: Item) {
        if let urlThumb = item.image?.first?.url {
            imageSong.sd_setImage(with: URL(string: urlThumb))
            imageSong.layer.cornerRadius = 10
            imageSong.clipsToBounds = true
        }
        nameSong.text = item.name
    }

}

struct JazzMusicTableViewCellViewModel {
    var item: Item
}
