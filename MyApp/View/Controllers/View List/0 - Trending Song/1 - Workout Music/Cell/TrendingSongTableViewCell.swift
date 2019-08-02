//
//  TrendingSongTableViewCell.swift
//  MyApp
//
//  Created by Tran Dinh Nhan on 6/6/18.
//  Copyright © 2018 Nhan Tran. All rights reserved.
//

import UIKit
import SDWebImage

class TrendingSongTableViewCell: UITableViewCell {

    @IBOutlet private weak var imageSong: UIImageView!
    @IBOutlet weak var nameTrendingSong: UILabel!
    @IBOutlet weak var singerSong: UILabel!
    var viewModel: TrendingSongTableViewCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            configureData(item: viewModel.item)
        }
    }
}

private extension TrendingSongTableViewCell {
    func configureData(item: Item) {
        if let urlThumb = item.image?.first?.url {
            imageSong.sd_setImage(with: URL(string: urlThumb))
            imageSong.layer.cornerRadius = 10
            imageSong.clipsToBounds = true
        }
        nameTrendingSong.text = item.name
        nameTrendingSong.text = item.name
    }
}

struct TrendingSongTableViewCellViewModel {
    var item: Item
}
