//
//  CategorySongTableCellVM.swift
//  MyApp
//
//  Created by Tran Dinh Nhan on 6/5/18.
//  Copyright © 2018 Nhan Tran. All rights reserved.
//

import UIKit

struct ItemPlayer {
    var uri: String
    var image: String
    var name: String
    var href: String
}

class CategorySongTableCellVM {
    enum Result {
        case success
        case failure(Error)
    }

    typealias Completion6 = (Result) -> Void
    fileprivate var itemsCategory: [Item] = []

    func refresh(completion: @escaping Completion6) {
        loadDataCategorySong(completion: completion)
    }

    func loadDataCategorySong(completion: @escaping Completion6) {
        let prameters = Api.Trending.Attribute(country: "VN",
                                               limit: 20,
                                               offset: 5)
        Api.Trending.Attribute.feeDataTrendingSongEDM(parameters: prameters) { [weak self] (result) in
            guard let this = self else { return }
            switch result {
            case .success(let data):
                guard let dataItem = data.playlist?.item else { return }
                this.itemsCategory.append(contentsOf: dataItem)
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    func numberOfRowsInSectionCategorySong() -> Int {
        return itemsCategory.count
    }

    func cellForRowAtCategorySongList(at indexPath: IndexPath) -> CategoryCollectionViewModel {
        return CategoryCollectionViewModel(item: itemsCategory[indexPath.row])
    }

    func viewModelForPlayCategorySong(at indexPath: IndexPath) -> PlayerSongViewModel {
        let data = itemsCategory.map { (item) -> PlayerSongViewModel.DataPlays in
            return PlayerSongViewModel.DataPlays(albumName: item.name ?? "",
                                                 uri: item.uri,
                                                 name: item.name ?? "",
                                                 image: item.image?.first?.url ?? "")
        }
        return PlayerSongViewModel(dataPlays: data)
    }

}
