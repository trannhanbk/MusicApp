//
//  ApiManager.swift
//  MyApp
//
//  Created by iOSTeam on 2/21/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import Alamofire

typealias JSObject = [String: Any]
typealias JSArray = [JSObject]

typealias Completion = (Result<Any>) -> Void
typealias CompletionSong = (Result<DataJSON>) -> Void
typealias CompletionAlbum = (Result<DataJsonAlbum>) -> Void
typealias CompletionAlbumHot = (Result<DataJsonAlbumHot>) -> Void
typealias CompletionListSong = (Result<DataPlaylists>) -> Void
typealias CompletionListAlbum = (Result<AlbumList>) -> Void
typealias CompletionListSearch = (Result<DataSearch>) -> Void

let api = ApiManager()

final class ApiManager {

    var defaultHTTPHeaders: [String: String] {
        let headers: [String: String] = ["Authorization": "Bearer \(String(describing: UserDefaults.standard.value(forKey: "kAccessToken") ?? ""))"]
        return headers
    }
}
