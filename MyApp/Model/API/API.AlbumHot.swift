//
//  API.AlbumHot.swift
//  MyApp
//
//  Created by Tran Dinh Nhan on 6/20/18.
//  Copyright © 2018 Nhan Tran. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

extension Api.AlbumHot {
    struct Attribute {
        let ids: String
        let market: String
        func toJSON() -> Parameters {
            return [ "ids": ids,
                     "market": market]
        }

        static func feedDataFeaturedPlaylistAlbum(parameters: Attribute, completion: @escaping CompletionAlbumHot) {
            let path = Api.Path.AlbumHot.albumHot
            api.request(method: .get, urlString: path, parameters: parameters.toJSON()) { (result) in
                Mapper<DataJsonAlbumHot>().map(result: result, completion: { (resultData) in
                    DispatchQueue.main.async {
                        completion(resultData)
                    }
                })
            }
        }
    }
}
