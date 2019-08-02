//
//  FavoriteViewModel.swift
//  MyApp
//
//  Created by Tran Dinh Nhan on 6/21/18.
//  Copyright © 2018 Nhan Tran. All rights reserved.
//

import Foundation
import RealmSwift

final class FavoriteSongViewModel: Object {
    let item = List<FavoriteSong>()

    func numberOfRowsInSection() -> Int {
        var count = 0
        do {
            let realm = try Realm()
            count = realm.objects(FavoriteSong.self).count - 1
        } catch {
            print("Error Realm Cound")
        }
        return count
    }

    func cellForRowAtListFavorite(at indexPath: IndexPath) -> FavoriteCellVM {
        return FavoriteCellVM(item: item[indexPath.row])
    }

    func editingStyle(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            do {
                let realm = try Realm()
                try realm.write {
                    let itemFavorite = realm.objects(FavoriteSong.self)[indexPath.row]
                    realm.delete(itemFavorite)
                    tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
                }
            } catch {
                print("Not delete")
            }
        }
    }

    func viewModelForPlaySongAlbumNewReleases(at indexPath: IndexPath) -> PlayerSongViewModel {
        do {
            let realm = try Realm()
            let itemFavotite = realm.objects(FavoriteSong.self)[indexPath.row + 1]
            let uri = itemFavotite.uri ?? ""
            let image = itemFavotite.image ?? ""
            let name = itemFavotite.name ?? ""
            return PlayerSongViewModel(dataPlays: [PlayerSongViewModel.DataPlays(albumName: name, uri: uri, name: name, image: image)])
        } catch {
            print("Error-------------------------")
        }
        return PlayerSongViewModel(dataPlays: [PlayerSongViewModel.DataPlays(albumName: "", uri: "", name: "", image: "")])
    }

}
