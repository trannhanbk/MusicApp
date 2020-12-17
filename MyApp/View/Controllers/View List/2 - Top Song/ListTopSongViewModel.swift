//
//  ListTopSongViewModel.swift
//  MyApp
//
//  Created by Tran Dinh Nhan on 6/6/18.
//  Copyright © 2018 Nhan Tran. All rights reserved.
//

import UIKit

class ListTopSongViewModel {

    enum Result {
        case success
        case failure(Error)
    }

    typealias Completion = (Result) -> Void
    fileprivate var items: [ItemAlbum] = []

    func refresh(completion: @escaping Completion) {
        loadDataNewrelease(completion: completion)
    }

    func loadDataNewrelease(completion: @escaping Completion) {
        let prameters = Api.NewRelease.Attribute(country: "VN",
                                                 limit: 35,
                                                 offset: 5)
        Api.NewRelease.Attribute.feedDataFeaturedPlaylistAlbum(parameters: prameters) { [weak self] (result) in
            guard let this = self else { return }
            switch result {
            case .success(let data):
                guard let dataItem = data.albums?.itemAlbums else { return }
                this.items.append(contentsOf: dataItem)
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func numberOfRowsInSectionTopSong() -> Int {
        return items.count
    }

    func viewModelForPlaySong(at indexPath: IndexPath) -> PlayerViewModel {
        let data = items.map { (item) -> PlayerViewModel.DataPlays in
            return PlayerViewModel.DataPlays(albumName: item.name,
                                                 uri: item.uri,
                                                 name: item.name,
                                                 image: item.image?.first?.url ?? "")
        }
        return PlayerViewModel(dataPlays: data)
    }

    func cellForRowAtTopSongList(at indexPath: IndexPath) -> ListTopSongTableCellVM {
        return ListTopSongTableCellVM(item: items[indexPath.row])
    }
}
