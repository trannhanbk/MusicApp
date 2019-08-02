//
//  SearchTableCell.swift
//  MyApp
//
//  Created by Tran Dinh Nhan on 7/2/18.
//  Copyright © 2018 Nhan Tran. All rights reserved.
//

import UIKit

class SearchTableCell: UITableViewCell {

    @IBOutlet weak var imageSong: UIImageView!
    @IBOutlet weak var nameSong: UILabel!
    @IBOutlet weak var singerSong: UILabel!

    var viewModel: SearchSongCellVM? {
        didSet {
            guard let viewModel = viewModel else { return }
            nameSong.text = viewModel.item.name
            singerSong.text = viewModel.item.artists.first?.name
            guard let urlImage = viewModel.item.album?.image.first?.url else { return }
            imageSong.sd_setImage(with: URL(string: urlImage))
            imageSong.layer.cornerRadius = 10
            imageSong.clipsToBounds = true
        }
    }
}
