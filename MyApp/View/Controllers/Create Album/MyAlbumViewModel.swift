//
//  MyAlbumViewModel.swift
//  MyApp
//
//  Created by Tran Dinh Nhan on 6/28/18.
//  Copyright © 2018 Nhan Tran. All rights reserved.
//

import Foundation
import RealmSwift

class MyAlbumViewModel {
    let item = List<MyAlbum>()

    func numberOfRowsInSection() -> Int {
        var count = 0
        do {
            let realm = try Realm()
            count = realm.objects(MyAlbum.self).count - 1
        } catch {
            print("Error Realm Cound")
        }
        return count
    }

    func cellForRowAtListMyAlbum(at indexPath: IndexPath) -> MyAlbumCellViewModel {
        return MyAlbumCellViewModel(item: item[indexPath.row])
    }

    func editingStyle(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            do {
                let realm = try Realm()
                try realm.write {
                    let itemAlbum = realm.objects(MyAlbum.self)[indexPath.row]
                    realm.delete(itemAlbum)
                    tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
                }
            } catch {
                print("Not delete")
            }
        }
    }

    func viewModelForListPlaySong(at indexPath: IndexPath) -> ListMyAlbumViewModel {
        do {
            let realm = try Realm()
            let itemFavotite = realm.objects(MyAlbum.self)[indexPath.row + 1]
            let name = itemFavotite.name ?? ""
            let href = itemFavotite.href ?? ""
            return ListMyAlbumViewModel(href: href, name: name)
        } catch {
            print("Error")
        }
        return ListMyAlbumViewModel(href: "", name: "")
    }
}
