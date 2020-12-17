//
//  SongEveryDayTableViewCell.swift
//  MyApp
//
//  Created by Tran Dinh Nhan on 6/4/18.
//  Copyright © 2018 Nhan Tran. All rights reserved.
//

import UIKit
import SDWebImage

class SongEveryDayTableViewCell: UITableViewCell {

    @IBOutlet weak var viewCell: UIView!
    @IBOutlet weak var visualView: UIVisualEffectView!
    @IBOutlet weak var imageSongEveryDay: UIImageView!
    @IBOutlet weak var imageSongSmall: UIImageView!
    @IBOutlet weak var nameSongEveryDay: UILabel!

    var viewModel: SongEveryDayCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            configureData(item: viewModel.item)
        }
    }

    func configureData(item: Item) {
        if let urlThumb = item.image?.first?.url {
            imageSongEveryDay.sd_setImage(with: URL(string: urlThumb))
            imageSongSmall.sd_setImage(with: URL(string: urlThumb))
            imageSongSmall.layer.cornerRadius = 4
            imageSongSmall.clipsToBounds = true
        }
        viewCell.backgroundColor = UIColor.clear
        viewCell.layer.cornerRadius = 4
        viewCell.clipsToBounds = true
        nameSongEveryDay.text = item.name
    }
}
