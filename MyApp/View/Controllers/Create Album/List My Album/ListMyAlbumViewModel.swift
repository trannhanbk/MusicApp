//
//  ListMyAlbumViewModel.swift
//  MyApp
//
//  Created by Tran Dinh Nhan on 6/28/18.
//  Copyright © 2018 Nhan Tran. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import RealmSwift

class ListMyAlbumViewModel {
    var name: String? = ""
    var href: String? = ""
    init(href: String? = "", name: String = "") {
        self.href = href
        self.name = name
    }

    enum Result {
        case success
        case failure(Error)
    }

    typealias Completion = (Result) -> Void
    var items: [ItemAlbums] = []

    func refresh(completion: @escaping Completion) {
        items.removeAll()
        loadData(completion: completion)
    }

    func loadData(completion: @escaping Completion) {
        feedDataFeaturedPlaylistMusicLike { [weak self] (result) in
            guard let this = self else { return }
            switch result {
            case .success(let data):
                this.items.append(contentsOf: data.items)
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func feedDataFeaturedPlaylistMusicLike(completion: @escaping CompletionListAlbum) {
        let href = self.href?.components(separatedBy: ":").last ?? ""
        let path = "https://api.spotify.com/v1/albums/\(href)/tracks?market=US&limit=12&offset=5"
        api.request(method: .get, urlString: path, parameters: nil) { (result) in
            Mapper<AlbumList>().map(result: result, completion: { (resultData) in
                DispatchQueue.main.async {
                    completion(resultData)
                }
            })
        }
    }

    func numberOfRowsInSection() -> Int {
        return items.count
    }

    func cellForRowAtListMyAlbum(at indexPath: IndexPath) -> ListMyCellVM {
        return ListMyCellVM(item: items[indexPath.row])
    }

    func actionPlaySong() -> PlayerViewModel {
        guard let name = name else { fatalError() }
        return PlayerViewModel(dataPlays: [PlayerViewModel.DataPlays(albumName: name, uri: href ?? "", name: name, image: "")])
    }

    func viewModelForPlaySong(at indexPath: IndexPath) -> PlayerViewModel {
        let data = items.map { (item) -> PlayerViewModel.DataPlays in
            return PlayerViewModel.DataPlays(albumName: name ?? "",
                                                 uri: item.uri,
                                                 name: item.name,
                                                 image: "")
        }
        return PlayerViewModel(dataPlays: data)
    }
}
