//
//  ImageProperties.swift
//  MyApp
//
//  Created by Tran Dinh Nhan on 6/13/18.
//  Copyright © 2018 Nhan Tran. All rights reserved.
//

import Foundation
import ObjectMapper

final class ImageProperties: Mappable {
    var url: String?
    var width: Int?
    var height: Int?

    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        url <- map["url"]
        height <- map["height"]
        width <- map["width"]
    }
}
