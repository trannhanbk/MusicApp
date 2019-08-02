//
//  TopSongTableViewCell.swift
//  MyApp
//
//  Created by Tran Dinh Nhan on 6/4/18.
//  Copyright © 2018 Nhan Tran. All rights reserved.
//

import UIKit

class TopSongTableViewCell: UITableViewCell {

    @IBOutlet weak var imageSong: UIImageView!
    @IBOutlet weak var nameSong: UILabel!
    @IBOutlet weak var singerSong: UILabel!
    var viewModel: TopSongCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            configureData(item: viewModel.item)
        }
    }

    func configureData(item: ItemAlbum) {
        if let urlThumb = item.image?.first?.url {
            imageSong.sd_setImage(with: URL(string: urlThumb))
            imageSong.layer.cornerRadius = 4
            imageSong.clipsToBounds = true
        }
        nameSong.text = item.name
        singerSong.text = item.artist.first?.name
    }
}
