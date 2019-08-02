//
//  KpopSongTableViewCell.swift
//  MyApp
//
//  Created by Tran Dinh Nhan on 6/15/18.
//  Copyright © 2018 Nhan Tran. All rights reserved.
//

import UIKit

class KpopSongTableViewCell: UITableViewCell {

    @IBOutlet private weak var imageKpopSong: UIImageView!
    @IBOutlet private weak var nameSong: UILabel!
    var viewModel: KpopSongTableViewCellVM? {
        didSet {
            guard let viewModel = viewModel else { return }
            configureData(item: viewModel.item)
        }
    }
}

private extension KpopSongTableViewCell {
    func configureData(item: Item) {
        if let urlThumb = item.image?.first?.url {
            imageKpopSong.sd_setImage(with: URL(string: urlThumb))
            imageKpopSong.layer.cornerRadius = 10
            imageKpopSong.clipsToBounds = true
        }
        nameSong.text = item.name
    }
}

struct KpopSongTableViewCellVM {
    var item: Item
}
