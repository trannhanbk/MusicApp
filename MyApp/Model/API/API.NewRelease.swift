//
//  API.NewRelease.swift
//  MyApp
//
//  Created by Tran Dinh Nhan on 6/18/18.
//  Copyright © 2018 Nhan Tran. All rights reserved.
//
import Foundation
import Alamofire
import ObjectMapper

extension Api.NewRelease {
    struct Attribute {
        let country: String
        let limit: Int
        let offset: Int
        func toJSON() -> Parameters {
            return [ "country": country,
                     "limit": limit,
                     "offset": offset]
        }

        static func feedDataFeaturedPlaylistAlbum(parameters: Attribute, completion: @escaping CompletionAlbum) {
            let path = Api.Path.NewRelease.Music()
            api.request(method: .get, urlString: path, parameters: parameters.toJSON()) { (result) in
                Mapper<DataJsonAlbum>().map(result: result, completion: { (resultData) in
                    DispatchQueue.main.async {
                        completion(resultData)
                    }
                })
            }
        }
    }
}
