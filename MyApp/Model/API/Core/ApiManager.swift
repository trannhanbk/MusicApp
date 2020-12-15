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
    let session = Session()


    var manager: SessionManager!

    var configuration: URLSessionConfiguration {
        let cf = URLSessionConfiguration.default
        cf.timeoutIntervalForRequest = 30
        cf.timeoutIntervalForResource = 30
        return cf
    }


    init() {
        manager = SessionManager(configuration: configuration)
        session.loadAccessToken()
    }

    var defaultHTTPHeaders: [String: String] {
        var headers: [String: String] = SessionManager.defaultHTTPHeaders
        if let accessToken = session.accessToken {
            headers["Authorization"] = "Bearer \(accessToken)"
        }
        
        headers["Content-Type"] = "application/json"
        let systemVersion = UIDevice.current.systemVersion
        if let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            let userAgent = "Appress/\(appVersion) (iPhone; iOS/\(systemVersion); Scale/\(UIScreen.main.scale))"
            headers["User-Agent"] = userAgent
        }
        return headers
    }
}
