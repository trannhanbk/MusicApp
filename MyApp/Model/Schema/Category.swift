//
//  Category.swift
//  MyApp
//
//  Created by Tran Dinh Nhan on 5/17/18.
//  Copyright © 2018 Nhan Tran. All rights reserved.
//

import UIKit

class Categories {
    var name: String
    var image: UIImage
    init(name: String, image: UIImage) {
        self.name = name
        self.image = image
    }

    static func initCategories() -> [Categories] {
        return [
            Categories(name: "Nhắn Gửi Thanh Xuân", image: #imageLiteral(resourceName: "nhan-gui-thanh-xuan")),
            Categories(name: "Đầu Tuần Nghe Gì?", image: #imageLiteral(resourceName: "dau tuan nghe gi")),
            Categories(name: "Nhạc Nghe Khi Làm Việc", image: #imageLiteral(resourceName: "nhac nghe khi lam viec")),
            Categories(name: "Giọng Hát Mới", image: #imageLiteral(resourceName: "giong hat moi")),
            Categories(name: "Pop Rising", image: #imageLiteral(resourceName: "pop "))
        ]
    }
}

class CategoryTrendingSong {
    var name: String
    var image: UIImage
    init(name: String, image: UIImage) {
        self.image = image
        self.name = name
    }

    static func initCategoryTrendingSong() -> [CategoryTrendingSong] {
        return [
            CategoryTrendingSong(name: "Workout Music", image: #imageLiteral(resourceName: "workout_music")),
            CategoryTrendingSong(name: "K-Pop", image: #imageLiteral(resourceName: "KPOP")),
            CategoryTrendingSong(name: "Electronic Dance", image: #imageLiteral(resourceName: "Electronic Dance")),
            CategoryTrendingSong(name: "Folk & Acoustic", image: #imageLiteral(resourceName: "Folk - Acoustic")),
            CategoryTrendingSong(name: "Jazz", image: #imageLiteral(resourceName: "Jazz"))
        ]
    }
}
