//
//  AlbumHot.swift
//  MyApp
//
//  Created by Tran Dinh Nhan on 6/25/18.
//  Copyright © 2018 Nhan Tran. All rights reserved.
//

import Foundation
import ObjectMapper

final class DataJsonAlbumHot: Mappable {
    var albumHots: [AlbumsHot] = []
    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        albumHots <- map["albums"]
    }
}

final class AlbumsHot: Mappable {
    var image: [Image] = []
    var label: String = ""
    var name: String = ""
    var tracks: Tracks?
    var uri: String = ""

    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        image <- map["images"]
        label <- map["label"]
        name <- map["name"]
        tracks <- map["tracks"]
        uri <- map["uri"]
    }
}

final class Tracks: Mappable {

    var itemAlbumHot: [ItemAlbumHot] = []

    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        itemAlbumHot <- map["items"]
    }
}

final class ItemAlbumHot: Mappable {
    var uriTrack: String = ""
    var name: String = ""
    var artists: [Artists] = []

    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        uriTrack <- map["uri"]
        name <- map["name"]
        artists <- map["artists"]
    }
}

final class Artists: Mappable {
    var name: String = ""
    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        name <- map["name"]
    }
}
