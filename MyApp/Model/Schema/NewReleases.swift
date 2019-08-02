//
//  Album.swift
//  MyApp
//
//  Created by Tran Dinh Nhan on 6/19/18.
//  Copyright © 2018 Nhan Tran. All rights reserved.
//

import Foundation
import ObjectMapper

final class DataJsonAlbum: Mappable {

    var albums: Albums?
    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        albums <- map["albums"]
    }
}

final class Albums: Mappable {
    var itemAlbums: [ItemAlbum] = []

    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        itemAlbums <- map["items"]
    }
}

final class ItemAlbum: Mappable {
    var href: String = ""
    var name: String = ""
    var uri: String = ""
    var image: [ImageProperties]?
    var releaseDate: String?
    var artist: [Artists] = []

    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        href <- map["href"]
        name <- map["name"]
        image <- map["images"]
        uri <- map["uri"]
        releaseDate <- map["release_date"]
        artist <- map["artists"]
    }
}

//final class Artists
