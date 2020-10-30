//
//  FavoriteTableViewCell.swift
//  MyApp
//
//  Created by Tran Dinh Nhan on 6/21/18.
//  Copyright © 2018 Nhan Tran. All rights reserved.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {

    @IBOutlet weak var imageSongFavorite: UIImageView!
    @IBOutlet weak var nameSong: UILabel!
    @IBOutlet weak var titleSong: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    func updateCell(data: FavoriteSong) {
        if let urlThumb = data.image {
            imageSongFavorite.sd_setImage(with: URL(string: urlThumb))
            imageSongFavorite.layer.cornerRadius = 10
            imageSongFavorite.clipsToBounds = true
        }
        nameSong.text = data.name
        titleSong.text = data.title
    }
}
