//
//  API.Trending.swift
//  MyApp
//
//  Created by Tran Dinh Nhan on 6/13/18.
//  Copyright © 2018 Nhan Tran. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

extension Api.Trending {
    //country=VN&limit=15&offset=2

    struct Attribute {
        let country: String
        let limit: Int
        let offset: Int
        func toJSON() -> Parameters {
            return [
                "country": country,
                "limit": limit,
                "offset": offset            ]
        }

        static func feedData(parameters: Attribute, completion: @escaping CompletionSong) {
            let path = Api.Path.Category.MusicWorkout()
            api.request(method: .get, urlString: path, parameters: parameters.toJSON()) { (result) in
                Mapper<DataJSON>().map(result: result, completion: { (resultData) in
                    DispatchQueue.main.async {
                        completion(resultData)
                    }
                })
            }
        }

        static func feeDataTrendingSongKpop(parameters: Attribute, completion: @escaping CompletionSong) {
            let path = Api.Path.Category.MusicKP()
            api.request(method: .get, urlString: path, parameters: parameters.toJSON()) { (result) in
                Mapper<DataJSON>().map(result: result, completion: { (resultData) in
                    DispatchQueue.main.async {
                        completion(resultData)
                    }
                })
            }
        }

        static func feeDataTrendingSongEDM(parameters: Attribute, completion: @escaping CompletionSong) {
            let path = Api.Path.Category.MusicEDM()
            api.request(method: .get, urlString: path, parameters: parameters.toJSON()) { (result) in
                Mapper<DataJSON>().map(result: result, completion: { (resultData) in
                    DispatchQueue.main.async {
                        completion(resultData)
                    }
                })
            }
        }

        static func feeDataTrendingSongFolk(parameters: Attribute, completion: @escaping CompletionSong) {
            let path = Api.Path.Category.MusicFolk()
            api.request(method: .get, urlString: path, parameters: parameters.toJSON()) { (result) in
                Mapper<DataJSON>().map(result: result, completion: { (resultData) in
                    DispatchQueue.main.async {
                        completion(resultData)
                    }
                })
            }
        }

        static func feeDataTrendingSongJazz(parameters: Attribute, completion: @escaping CompletionSong) {
            let path = Api.Path.Category.MusicJazz()
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
