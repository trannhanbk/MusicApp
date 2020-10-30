//
//  CollectionViewCell.swift
//  MyApp
//
//  Created by Tran Dinh Nhan on 6/5/18.
//  Copyright © 2018 Nhan Tran. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var viewCell: UIVisualEffectView!
    @IBOutlet private weak var imageCategoryView: UIImageView!
    @IBOutlet private weak var nameCategory: UILabel!
    var viewModel: CategoryCollectionViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            configureData(item: viewModel.item)
        }
    }

    func configureData(item: Item) {
        if let urlThumb = item.image?.first?.url {
            imageCategoryView.sd_setImage(with: URL(string: urlThumb))
            imageCategoryView.layer.cornerRadius = 4
            imageCategoryView.clipsToBounds = true
        }
        nameCategory.text = item.name
        viewCell.layer.cornerRadius = 4
        viewCell.clipsToBounds = true
    }
}
