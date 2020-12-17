//
//  SearchViewModel.swift
//  MyApp
//
//  Created by Tran Dinh Nhan on 5/28/18.
//  Copyright © 2018 Nhan Tran. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift
final class SearchViewModel {
    enum Result {
        case success
        case failure(error: Error)
    }

    var itemSerch: [ItemSearch] = []

    func numberOfSpotifyMusic() -> Int {
        return itemSerch.count
    }

    func fetchData(data: [ItemSearch]) {
        itemSerch.append(contentsOf: data)
    }

    func searchItem(keyword: String, completion: @escaping (Result) -> Void) {
        if !keyword.isEmpty {
            let prameter = Api.SearchSong.Attribute(q: keyword,
                                                    type: "track,album,artist,playlist",
                                                    market: "VN",
                                                    limit: "40",
                                                    offset: "5")
            Api.SearchSong.detchData(parameters: prameter) { [weak self] (result) in
                guard let this = self else { return }
                switch result {
                case .success(let data):
                    print(data)
                    guard let dataItem = data.tracks?.item else { return }
                    this.itemSerch.append(contentsOf: dataItem)
                    completion(.success)
                case .failure(let error):
                    completion(.failure(error: error))
                }
            }
        } else {
            itemSerch.removeAll()
            completion(.success)
        }
    }

    func cellForRowAtSearchSongList(at indexPath: IndexPath) -> SearchSongCellVM {
        return SearchSongCellVM(item: itemSerch[indexPath.row])
    }

    func didSelectRowAtPlaySong(at indexPath: IndexPath) -> PlayerViewModel {
        let data = itemSerch.map { (item) -> PlayerViewModel.DataPlays in
            return PlayerViewModel.DataPlays(albumName: item.name ?? "",
                                                 uri: item.uri,
                                                 name: item.name ?? "",
                                                 image: item.album?.image.first?.url ?? "")
        }
        return PlayerViewModel(dataPlays: data)
    }
}
