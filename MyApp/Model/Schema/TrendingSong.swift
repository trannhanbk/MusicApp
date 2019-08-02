//
//  TrendingSong.swift
//  MyApp
//
//  Created by Tran Dinh Nhan on 6/13/18.
//  Copyright © 2018 Nhan Tran. All rights reserved.
//

import Foundation
import ObjectMapper

final class DataJSON: Mappable {
    var playlist: Playlist?

    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        playlist <- map["playlists"]
    }
}

final class Playlist: Mappable {
    var item: [Item] = []

    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        item <- map["items"]
    }
}
