//
//  ListCategorySongViewModel.swift
//  MyApp
//
//  Created by Tran Dinh Nhan on 6/6/18.
//  Copyright © 2018 Nhan Tran. All rights reserved.
//

import UIKit

class ListCategorySongViewModel {
    enum Result {
        case success
        case failure(Error)
    }

    typealias Completion = (Result) -> Void
    var items: [Item] = []

    func refresh(completion: @escaping Completion) {
        items.removeAll()
        loadData(completion: completion)
    }

    func loadData(completion: @escaping Completion) {
        let prameters = Api.Trending.Attribute(country: "VN",
                                               limit: 50,
                                               offset: 5)
        Api.Trending.Attribute.feeDataTrendingSongEDM(parameters: prameters) { [weak self] (result) in
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

    func cellForRowAtTrendingSongList(at indexPath: IndexPath) -> ListCategorySongCollectionCellVM {
        return ListCategorySongCollectionCellVM(item: items[indexPath.row])
    }

    func viewModelForListCategory(at indexPath: IndexPath) -> ListCategoryItemViewModel {
        let trackHref = items[indexPath.row].tracks?.href
        guard let href = trackHref else { fatalError() }
        let nameItem = items[indexPath.row].name
        guard let name = nameItem else { fatalError() }
        let image = items[indexPath.row].image?.first?.url
        guard let imageURL = image else { fatalError() }
        let uri = items[indexPath.row].uri
        return ListCategoryItemViewModel(href: href, name: name, image: imageURL, uri: uri)
    }
}
