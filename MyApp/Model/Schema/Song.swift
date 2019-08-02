//
//  Song.swift
//  MyApp
//
//  Created by Tran Dinh Nhan on 5/18/18.
//  Copyright © 2018 Nhan Tran. All rights reserved.
//

import Foundation
import ObjectMapper

class Song: Mappable {
    var name: String?
    var uri: String?
    var images: [Image] = []

    required init?(map: Map) {}

    func mapping(map: Map) {
        name <- map["name"]
        uri <- map["name"]
        images <- map["images"]
    }
}

class Image: Mappable {

    var width: Double?
    var height: Double?
    var url: String = ""

    required init?(map: Map) {}

    func mapping(map: Map) {
        width <- map["width"]
        url <- map["url"]
        height <- map["height"]
    }
}
