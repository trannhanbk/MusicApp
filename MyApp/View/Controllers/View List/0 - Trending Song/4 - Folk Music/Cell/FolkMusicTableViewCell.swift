//
//  FolkMusicTableViewCell.swift
//  MyApp
//
//  Created by Tran Dinh Nhan on 6/15/18.
//  Copyright © 2018 Nhan Tran. All rights reserved.
//

import UIKit

class FolkMusicTableViewCell: UITableViewCell {

    @IBOutlet weak var imageFolkMusic: UIImageView!
    @IBOutlet weak var nameCategoryFolk: UILabel!
    var viewModel: FolkMusicTableViewCellVM? {
        didSet {
            guard let viewModel = viewModel else { return }
            configureData(item: viewModel.item)
        }
    }
}

private extension FolkMusicTableViewCell {
    func configureData(item: Item) {
        if let urlThumb = item.image?.first?.url {
            imageFolkMusic.sd_setImage(with: URL(string: urlThumb))
            imageFolkMusic.layer.cornerRadius = 10
            imageFolkMusic.clipsToBounds = true
        }
        nameCategoryFolk.text = item.name
    }
}

struct FolkMusicTableViewCellVM {
    var item: Item
}
