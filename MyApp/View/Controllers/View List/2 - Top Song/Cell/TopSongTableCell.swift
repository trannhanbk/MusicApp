//
//  TopSongTableCell.swift
//  MyApp
//
//  Created by Tran Dinh Nhan on 6/6/18.
//  Copyright © 2018 Nhan Tran. All rights reserved.
//

import UIKit

class TopSongTableCell: UITableViewCell {

    @IBOutlet weak var imageTopSong: UIImageView!
    @IBOutlet weak var nameTopSong: UILabel!
    @IBOutlet weak var nameSinger: UILabel!
    @IBOutlet weak var numberSong: UILabel!
    var viewModel: ListTopSongTableCellVM? {
        didSet {
            guard let viewModel = viewModel else { return }
            configureData(item: viewModel.item)
        }
    }

    func configureData(item: ItemAlbum) {
        if let urlThumb = item.image?.first?.url {
            imageTopSong.sd_setImage(with: URL(string: urlThumb))
            imageTopSong.layer.cornerRadius = 10
            imageTopSong.clipsToBounds = true
        }
        nameTopSong.text = item.name
        nameSinger.text = item.artist.first?.name
    }
}
