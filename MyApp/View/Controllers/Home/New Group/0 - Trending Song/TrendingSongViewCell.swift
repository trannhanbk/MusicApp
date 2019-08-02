//
//  TrendingSongViewCell.swift
//  MyApp
//
//  Created by Tran Dinh Nhan on 5/17/18.
//  Copyright © 2018 Nhan Tran. All rights reserved.
//

import UIKit
import SDWebImage

class TrendingSongViewCell: UICollectionViewCell {

    @IBOutlet var imageCategorySmall: UIImageView!
    @IBOutlet private weak var imageCategoryTrending: UIImageView!
    @IBOutlet private weak var textlabel: UILabel!
    var viewModel: HomeCellTrendingSongViewModel? {
        didSet {
            updateView()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func updateView() {
        guard let viewModel = viewModel else { return }
        textlabel.text = viewModel.nameCategory
        imageCategorySmall.image = viewModel.imageCategorySmall
        imageCategorySmall.layer.cornerRadius = 4
        imageCategorySmall.clipsToBounds = true
        imageCategoryTrending.image = viewModel.imageCategory
    }
}
