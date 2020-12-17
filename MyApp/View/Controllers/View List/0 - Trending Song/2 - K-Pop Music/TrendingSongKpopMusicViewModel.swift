//
//  TrendingSongKpopMusicViewModel.swift
//  MyApp
//
//  Created by Tran Dinh Nhan on 6/15/18.
//  Copyright © 2018 Nhan Tran. All rights reserved.
//

import Foundation

class TrendingSongKpopMusicViewModel {
    enum Result {
        case success
        case failure(Error)
    }

    typealias Completion = (Result) -> Void
    fileprivate var items: [Item] = []

    func refresh(completion: @escaping Completion) {
        items.removeAll()
        loadData(completion: completion)
    }

    func loadData(completion: @escaping Completion) {
        let prameters = Api.Trending.Attribute(country: "VN",
                                               limit: 30,
                                               offset: 5)
        Api.Trending.Attribute.feeDataTrendingSongKpop(parameters: prameters) { [weak self] (result) in
            guard let this = self else { return }
            switch result {
            case .success(let data):
                guard let dataItem = data.playlist?.item else { return }
                this.items.append(contentsOf: dataItem)
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    func numberOfRowsInSection() -> Int {
        return items.count
    }

    func cellForRowAtTrendingSongList(at indexPath: IndexPath) -> KpopSongTableViewCellVM {
        return KpopSongTableViewCellVM(item: items[indexPath.row])
    }

    func viewModelForPlaySong(at indexPath: IndexPath) -> PlayerViewModel {
        let data = items.map { (item) -> PlayerViewModel.DataPlays in
            return PlayerViewModel.DataPlays(albumName: item.name ?? "",
                                                 uri: item.uri,
                                                 name: item.name ?? "",
                                                 image: item.image?.first?.url ?? "")
        }
        return PlayerViewModel(dataPlays: data)
    }

}
