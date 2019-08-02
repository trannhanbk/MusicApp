//
//  ListCategorySongCollectionCell.swift
//  MyApp
//
//  Created by Tran Dinh Nhan on 6/6/18.
//  Copyright © 2018 Nhan Tran. All rights reserved.
//

import UIKit

class ListCategorySongCollectionCell: UICollectionViewCell {

    @IBOutlet weak var visualView: UIVisualEffectView!
    @IBOutlet weak var imageCategory: UIImageView!
    @IBOutlet weak var nameCategory: UILabel!
    var viewModel: ListCategorySongCollectionCellVM? {
        didSet {
            guard let viewModel = viewModel else { return }
            configureData(item: viewModel.item)
        }
    }

    func configureData(item: Item) {
        if let urlThumb = item.image?.first?.url {
            imageCategory.sd_setImage(with: URL(string: urlThumb))
            imageCategory.layer.cornerRadius = 4
            imageCategory.clipsToBounds = true
        }
        visualView.layer.cornerRadius = 4
        visualView.clipsToBounds = true
        nameCategory.text = item.name
    }
}
