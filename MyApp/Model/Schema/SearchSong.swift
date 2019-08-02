//
//  SearchSong.swift
//  MyApp
//
//  Created by Tran Dinh Nhan on 7/2/18.
//  Copyright © 2018 Nhan Tran. All rights reserved.
//

import Foundation
import ObjectMapper

final class DataSearch: Mappable {
//    var artist: ArtistsSearch?
    var tracks: TracksSearch?

    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        tracks <- map["tracks"]
    }
}

final class TracksSearch: Mappable {
    var item: [ItemSearch] = []

    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        item <- map["items"]
    }
}

final class ItemSearch: Mappable {
    var artists: [Artists] = []
    var uri: String = ""
    var name: String?
    var album: Album?
    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        artists <- map["artists"]
        uri <- map["uri"]
        name <- map["name"]
        album <- map["album"]
    }
}
