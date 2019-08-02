//
//  ListMyAlbumTableViewCell.swift
//  MyApp
//
//  Created by Tran Dinh Nhan on 6/28/18.
//  Copyright © 2018 Nhan Tran. All rights reserved.
//

import UIKit

class ListMyAlbumTableViewCell: UITableViewCell {

    @IBOutlet private weak var imageSong: UIImageView!
    @IBOutlet private weak var singerSong: UILabel!
    @IBOutlet private weak var titleSong: UILabel!
    var viewModel: ListMyCellVM? {
        didSet {
            guard let viewModel = viewModel else { return }
//            guard let image = viewModel.item.tracks?.album?.image.first?.url else { return }
//            imageSong.sd_setImage(with: URL(string: image))
            imageSong.layer.cornerRadius = 10
            imageSong.clipsToBounds = true
            titleSong.text = viewModel.item.name
            singerSong.text = viewModel.item.artists.first?.name
        }
    }
}
