//
//  ListSongDayTableCell.swift
//  MyApp
//
//  Created by Tran Dinh Nhan on 6/6/18.
//  Copyright © 2018 Nhan Tran. All rights reserved.
//

import UIKit

class ListSongDayTableCell: UITableViewCell {

    @IBOutlet private weak var singerSong: UILabel!
    @IBOutlet private weak var nameSong: UILabel!
    @IBOutlet private weak var imageSongDay: UIImageView!
    var viewModel: LisSongDayTableCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            nameSong.text = viewModel.item.tracks?.name
            singerSong.text = viewModel.item.tracks?.artists.first?.name
            guard let image = viewModel.item.tracks?.album?.image.first?.url else { return }
            imageSongDay.sd_setImage(with: URL(string: image))
            imageSongDay.layer.cornerRadius = 10
            imageSongDay.clipsToBounds = true
        }
    }
}
