//
//  ListCategoryItemViewModel.swift
//  MyApp
//
//  Created by Tran Dinh Nhan on 6/6/18.
//  Copyright © 2018 Nhan Tran. All rights reserved.
//

import UIKit
import ObjectMapper
import Alamofire

class ListCategoryItemViewModel {
    var name: String = ""
    var href: String? = ""
    var image: String = ""
    var uri: String = ""
    init(href: String? = "", name: String = "", image: String = "", uri: String = "") {
        self.href = href
        self.name = name
        self.image = image
        self.uri = uri
    }

    enum Result {
        case success
        case failure(Error)
    }

    typealias Completion = (Result) -> Void
    var items: [DataItem] = []

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

    func feedDataFeaturedPlaylistMusicLike(completion: @escaping CompletionListSong) {
        guard let path = href else { fatalError() }
        api.request(method: .get, urlString: path, parameters: nil) { (result) in
            Mapper<DataPlaylists>().map(result: result, completion: { (resultData) in
                DispatchQueue.main.async {
                    completion(resultData)
                }
            })
        }
    }

    func numberOfRowsInSection() -> Int {
        return items.count
    }

    func cellForRowAtTrendingSongList(at indexPath: IndexPath) -> ListCategoryItemTableCellVM {
        return ListCategoryItemTableCellVM(item: items[indexPath.row])
    }

    func actionPlaySong() -> PlayerViewModel {
        let data = items.map { (item) -> PlayerViewModel.DataPlays in
            return PlayerViewModel.DataPlays(albumName: name,
                                                 uri: item.tracks?.album?.uri ?? "",
                                                 name: item.tracks?.name ?? "",
                                                 image: item.tracks?.album?.image.first?.url ?? "")
        }
        return PlayerViewModel(dataPlays: data)
    }

    func viewModelForPlaySong(at indexPath: IndexPath) -> PlayerViewModel {
        let data = items.map { (item) -> PlayerViewModel.DataPlays in
            return PlayerViewModel.DataPlays(albumName: name,
                                                 uri: item.tracks?.album?.uri ?? "",
                                                 name: item.tracks?.name ?? "",
                                                 image: item.tracks?.album?.image.first?.url ?? "")
        }
        return PlayerViewModel(dataPlays: data)
    }
}
