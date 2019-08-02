//
//  CategorySongTableCell.swift
//  MyApp
//
//  Created by Tran Dinh Nhan on 6/6/18.
//  Copyright © 2018 Nhan Tran. All rights reserved.
//

import UIKit

class ListCategorySongTableCell: UITableViewCell {

    @IBOutlet private weak var imageSong: UIImageView!
    @IBOutlet private weak var nameSong: UILabel!
    @IBOutlet private weak var singerName: UILabel!
    var viewModel: ListCategoryItemTableCellVM? {
        didSet {
            guard let viewModel = viewModel else { return }
            configureData(item: viewModel.item)
        }
    }

    func configureData(item: DataItem) {
        nameSong.text = item.tracks?.name
        singerName.text = item.tracks?.artists.first?.name
        guard let image = item.tracks?.album?.image.first?.url else { return }
        imageSong.sd_setImage(with: URL(string: image))
        imageSong.layer.cornerRadius = 4
        imageSong.clipsToBounds = true
    }
}
