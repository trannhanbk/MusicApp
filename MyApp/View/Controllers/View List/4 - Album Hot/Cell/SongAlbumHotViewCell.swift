//
//  SongAlbumHotViewCell.swift
//  MyApp
//
//  Created by Tran Dinh Nhan on 6/25/18.
//  Copyright © 2018 Nhan Tran. All rights reserved.
//

import UIKit

class SongAlbumHotViewCell: UITableViewCell {

    @IBOutlet weak var imageSongView: UIImageView!
    @IBOutlet private weak var titleSong: UILabel!
    @IBOutlet weak var nameAlbumSong: UILabel!

    var viewModel: AlbumHotTableViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            guard let image = viewModel.tracks.tracks?.album?.image.first?.url else { return }
            imageSongView.sd_setImage(with: URL(string: image))
            imageSongView.layer.cornerRadius = 10
            imageSongView.clipsToBounds = true
            titleSong.text = viewModel.tracks.tracks?.name
            nameAlbumSong.text = viewModel.tracks.tracks?.artists.first?.name
        }
    }
}
