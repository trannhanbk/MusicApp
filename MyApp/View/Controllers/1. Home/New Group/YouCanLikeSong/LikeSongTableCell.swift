//
//  LikeSongTableCell.swift
//  MyApp
//
//  Created by Tran Dinh Nhan on 6/5/18.
//  Copyright © 2018 Nhan Tran. All rights reserved.
//

import UIKit

class LikeSongTableCell: UITableViewCell {

    @IBOutlet private weak var singerSong: UILabel!
    @IBOutlet private weak var titleSong: UILabel!
    @IBOutlet private weak var imageLikeSong: UIImageView!
    var viewModel: LikeSongViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            configureData(item: viewModel.item)
        }
    }

    func configureData(item: Item) {
        if let urlThumb = item.image?.first?.url {
            imageLikeSong.sd_setImage(with: URL(string: urlThumb))
            imageLikeSong.layer.cornerRadius = 4
            imageLikeSong.clipsToBounds = true
        }
        titleSong.text = item.name
    }
}
