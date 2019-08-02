//
//  HomCell2ViewModel.swift
//  MyApp
//
//  Created by Tran Dinh Nhan on 6/4/18.
//  Copyright © 2018 Nhan Tran. All rights reserved.
//

import UIKit

class HomeCellTopSongViewModel {
    var imageCategoryItem: UIImage
    var nameCategoryItem: String

    init(imageCategory: UIImage = #imageLiteral(resourceName: "nhan-gui-thanh-xuan"), nameCategoryItem: String = "") {
        self.imageCategoryItem = imageCategory
        self.nameCategoryItem = nameCategoryItem
    }
}
