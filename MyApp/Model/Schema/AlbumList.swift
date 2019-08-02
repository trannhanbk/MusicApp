//
//  AlbumList.swift
//  MyApp
//
//  Created by Tran Dinh Nhan on 6/28/18.
//  Copyright © 2018 Nhan Tran. All rights reserved.
//

import Foundation
import ObjectMapper

final class AlbumList: Mappable {
    var items: [ItemAlbums] = []

    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        items <- map["items"]
    }
}

final class ItemAlbums: Mappable {
    var name: String = ""
    var uri: String = ""
    var artists: [Artists] = []
    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        name <- map["name"]
        uri <- map["uri"]
        artists <- map["artists"]
    }
}
