//
//  File.swift
//  MyApp
//
//  Created by Tran Dinh Nhan on 5/17/18.
//  Copyright © 2018 Nhan Tran. All rights reserved.
//

import UIKit

class MusicViewModel {
    // MARK: - Struct
    var categoriesData: [Categories] = []
    var musicData: [Music] = []
    var arrSong: [Song] = [
        Song(fileName: "AMN", type: "mp3", title: "Anh muốn nói", singer: "Trịnh Thăng Bình", isPlaying: false),
        Song(fileName: "DNXE", type: "mp3", title: "Đếm ngày xa em", singer: "Only C, Lou Hoàng", isPlaying: false),
        Song(fileName: "CTKTVN", type: "mp3", title: "Chúng ta không thuộc về nhau", singer: "Sơn Tùng M-TP", isPlaying: false),
        Song(fileName: "DM", type: "mp3", title: "Dấu mưa", singer: "Trung Quân Idol", isPlaying: false),
        Song(fileName: "ECDD", type: "mp3", title: "Em cứ đi đi", singer: "Vương Anh Tú", isPlaying: false),
        Song(fileName: "VTCS", type: "mp3", title: "Vì tôi còn sống", singer: "Tiên Tiên", isPlaying: false),
        Song(fileName: "TMW", type: "mp3", title: "Tell me why", singer: "Hoà Minzy", isPlaying: false),
        Song(fileName: "DADM", type: "mp3", title: "Đâu ai đợi mình", singer: "Trịnh Thăng Bình", isPlaying: false)
    ]

    var arrSongHot: [Categories] = [
        Categories(name: "Đón hè nhẹ nhàng", image: #imageLiteral(resourceName: "TMW")),
        Categories(name: "Nhạc tiền chiến", image: #imageLiteral(resourceName: "CTKTVN")),
        Categories(name: "Đón hè nhẹ nhàng", image: #imageLiteral(resourceName: "WDTAM")),
        Categories(name: "Nhạc trẻ", image: #imageLiteral(resourceName: "DADM")),
        Categories(name: "Đón hè nhẹ nhàng", image: #imageLiteral(resourceName: "TMW")),
        Categories(name: "Nhạc tiền chiến", image: #imageLiteral(resourceName: "CTKTVN")),
        Categories(name: "Đón hè nhẹ nhàng", image: #imageLiteral(resourceName: "WDTAM")),
        Categories(name: "Đón hè nhẹ nhàng", image: #imageLiteral(resourceName: "TMW")),
        Categories(name: "Nhạc tiền chiến", image: #imageLiteral(resourceName: "CTKTVN")),
        Categories(name: "Đón hè nhẹ nhàng", image: #imageLiteral(resourceName: "WDTAM"))
    ]

    func numberOfRowsInSection() -> Int {
        return 1
    }

    func numberOfSections() -> Int {
        return categoriesData.count
    }

    func musicNumberOfRowsInSection() -> Int {
        return musicData.count
    }
}
