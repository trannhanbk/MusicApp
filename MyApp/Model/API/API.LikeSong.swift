//
//  API.LikeSong.swift
//  MyApp
//
//  Created by Tran Dinh Nhan on 6/20/18.
//  Copyright © 2018 Nhan Tran. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

extension Api.LikeSong {
    struct Attribute {
        let country: String
        let limit: Int
        let offset: Int
        func toJSON() -> Parameters {
            return [ "country": country,
                     "limit": limit,
                     "offset": offset]
        }

        static func feedDataFeaturedPlaylistMusicLike(parameters: Attribute, completion: @escaping CompletionSong) {
            let path = Api.Path.Category.MusicKP()
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
