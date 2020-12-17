//
//  HomeCellTrendingSongViewModel.swift
//  MyApp
//
//  Created by Tran Dinh Nhan on 6/4/18.
//  Copyright © 2018 Nhan Tran. All rights reserved.
//

import UIKit

class TrendingCellVM {
    var imageCategory: UIImage?
    var imageCategorySmall: UIImage?
    var nameCategory: String?

    init(imageCategory: UIImage = #imageLiteral(resourceName: "nhan-gui-thanh-xuan"), imageCategorySmall: UIImage = #imageLiteral(resourceName: "nhan-gui-thanh-xuan"), nameCategory: String = "") {
        self.imageCategory = imageCategory
        self.imageCategorySmall = imageCategorySmall
        self.nameCategory = nameCategory
    }
}
