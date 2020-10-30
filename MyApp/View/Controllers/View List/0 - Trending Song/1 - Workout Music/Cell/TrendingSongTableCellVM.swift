//
//  TrendingSongTableCellVM.swift
//  MyApp
//
//  Created by Tran Dinh Nhan on 6/6/18.
//  Copyright © 2018 Nhan Tran. All rights reserved.
//

import UIKit

class TrendingSongTableCellVM {
    var nameTrendingSong: String?
    var nameSinger: String?
    var imageSong: UIImage?

    init(nameTrendingSong: String = "", nameSinger: String = "", imageSong: UIImage = #imageLiteral(resourceName: "nhan-gui-thanh-xuan")) {
        self.nameTrendingSong = nameTrendingSong
        self.nameSinger = nameSinger
        self.imageSong = imageSong
    }
}
