//
//  API.SearchSong.swift
//  MyApp
//
//  Created by Tran Dinh Nhan on 7/2/18.
//  Copyright © 2018 Nhan Tran. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

extension Api.SearchSong {
    struct Attribute {
        let q: String
        let type: String
        let market: String
        let limit: String
        let offset: String

        func toJSON() -> Parameters {
            return [
                "q": q,
                "type": type,
                "market": market,
                "limit": limit,
                "offset": offset
            ]
        }
    }

    static func detchData(parameters: Attribute, completion: @escaping CompletionListSearch) {
        let path = Api.Path.SearchSuggest.Keyword()
//        return api.request(method: .get, urlString: path, parameters: parameters.toJSON()) { result in
//            DispatchQueue.main.async {
//                completion(result)
//            }
//        }
        api.request(method: .get, urlString: path, parameters: parameters.toJSON()) { (result) in
            Mapper<DataSearch>().map(result: result, completion: { (resultData) in
                DispatchQueue.main.async {
                    completion(resultData)
                }
            })
        }
    }
}
