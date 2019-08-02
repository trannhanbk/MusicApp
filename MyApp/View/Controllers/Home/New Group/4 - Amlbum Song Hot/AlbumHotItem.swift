//
//  AlbumHotItem.swift
//  MyApp
//
//  Created by Tran Dinh Nhan on 6/5/18.
//  Copyright © 2018 Nhan Tran. All rights reserved.
//

import UIKit

class AlbumHotItem: UICollectionViewCell {

    @IBOutlet weak var nameSinger: UILabel!
    @IBOutlet weak var titleAlbum: UILabel!
    @IBOutlet weak var imageAlbum: UIImageView!
    var viewModel: AlbumItemCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            configureData(item: viewModel.item)
        }
    }

    func configureData(item: Item) {
        guard let image = item.image?.first?.url else { return }
        imageAlbum.sd_setImage(with: URL(string: image))
        imageAlbum.layer.cornerRadius = 4
        imageAlbum.clipsToBounds = true
        titleAlbum.text = item.name
    }
}
