//
//  ListSongView.swift
//  MyApp
//
//  Created by Tran Dinh Nhan on 6/26/18.
//  Copyright © 2018 Nhan Tran. All rights reserved.
//

import Foundation
import ObjectMapper

final class DataPlaylists: Mappable {
    var items: [DataItem] = []
    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        items <- map["items"]
    }
}

final class DataItem: Mappable {
    var tracks: DataTracks?
    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        tracks <- map["track"]
    }
}

final class DataTracks: Mappable {
    var name: String = ""
    var uri: String = ""
    var artists: [Artists] = []
    var album: Album?
    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        name <- map["name"]
        uri <- map["uri"]
        artists <- map["artists"]
        album <- map["album"]
    }
}

final class Album: Mappable {
    var image: [Image] = []
    var uri: String = ""
    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        image <- map["images"]
        uri <- map["uri"]
    }
}
