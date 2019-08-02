//
//  Item.swift
//  MyApp
//
//  Created by Tran Dinh Nhan on 6/13/18.
//  Copyright © 2018 Nhan Tran. All rights reserved.
//

import Foundation
import ObjectMapper

class Item: Mappable {
    var href: String = ""
    var name: String?
    var uri: String = ""
    var image: [ImageProperties]?
    var tracks: Tracks1?

    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        name <- map["name"]
        image <- map["images"]
        uri <- map["uri"]
        tracks <- map["tracks"]
        href <- map["href"]
    }
}

final class Tracks1: Mappable {
    var href: String = ""
    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        href <- map["href"]
    }
}
