//
//  AlbumSongTableCellVM.swift
//  MyApp
//
//  Created by Tran Dinh Nhan on 6/5/18.
//  Copyright © 2018 Nhan Tran. All rights reserved.
//

import UIKit

class AlbumSongTableCellVM {
    enum Result {
        case success
        case failure(Error)
    }

    typealias Completion4 = (Result) -> Void
    fileprivate var itemsAlbumHot: [Item] = []

    func numberOfRowsInSection() -> Int {
        return itemsAlbumHot.count
    }

    func viewModelForPlaySongAlbumHot(at indexPath: IndexPath) -> PlayerSongViewModel {
        let uri = itemsAlbumHot[indexPath.row].uri
        guard let name = itemsAlbumHot[indexPath.row].name else { fatalError() }
        guard let imageURL = itemsAlbumHot[indexPath.row].image?.first?.url else { fatalError() }
        return PlayerSongViewModel(dataPlays: [PlayerSongViewModel.DataPlays(albumName: name, uri: uri, name: name, image: imageURL)])
    }
}
