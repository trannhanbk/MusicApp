//
//  API.FeaturedPlaylists.swift
//  MyApp
//
//  Created by Tran Dinh Nhan on 6/18/18.
//  Copyright © 2018 Nhan Tran. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

extension Api.FeaturedPlaylist {

//country=VN&locale=VN_VI&timestamp=2018-04-23T09%3A00%3A00&limit=15&offset=5

    struct Attribute {
        let country: String
        let locale: String
        let timestamp: String
        let limit: Int
        let offset: Int
        func toJSON() -> Parameters {
            return [ "country": country,
                     "locale": locale,
                     "timestamp": timestamp,
                     "limit": limit,
                     "offset": offset]
        }

        static func feedDataFeaturedPlaylist(parameters: Attribute, completion: @escaping CompletionSong) {
            let path = Api.Path.FeaturedPlaylists.Music()
            api.request(method: .get, urlString: path, parameters: parameters.toJSON()) { (result) in
                Mapper<DataJSON>().map(result: result, completion: { (resultData) in
                    DispatchQueue.main.async {
                        completion(resultData)
                    }
                })
            }
        }
    }
}
