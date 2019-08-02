//
//  PlayerSongViewModel.swift
//  MyApp
//
//  Created by Tran Dinh Nhan on 6/14/18.
//  Copyright © 2018 Nhan Tran. All rights reserved.
//

import Foundation
import RealmSwift

class PlayerSongViewModel {
    var dataPlays: [DataPlays] = []

    init(dataPlays: [DataPlays] = []) {
        self.dataPlays = dataPlays
    }

    struct DataPlays {
        var albumName: String = ""
        var uri: String = ""
        var name: String = ""
        var image: String = ""
    }
    var indexSelected = 0

    struct Play {
        var indexSelected: Int
        var data: [DataPlays]
    }

    func addOject(data: SPTAudioStreamingController) {
        do {

            let realm = try Realm()
            try realm.write {
                let itemFavorite = FavoriteSong()
                let name = data.metadata.currentTrack?.name
                let uri = data.metadata.currentTrack?.uri
                let image = data.metadata.currentTrack?.albumCoverArtURL
                let title = data.metadata.currentTrack?.artistName
                for item in realm.objects(FavoriteSong.self) {
                    if (item.name != name) && (item.uri != uri) {
                        itemFavorite.name = name
                        itemFavorite.uri = uri
                        itemFavorite.image = image
                        itemFavorite.title = title
                    } else {
                        realm.delete(item)
                        print("Delete -----------")
                    }
                }
                realm.add(itemFavorite)
            }
        } catch {
            print("Error with Realm")
        }
    }

    func addObjectAlbum(data: SPTAudioStreamingController) {
        do {
            let realm = try Realm()
            print(realm.objects(MyAlbum.self))
            try realm.write {
                let itemAlbum = MyAlbum()
                let albumName = data.metadata.currentTrack?.albumName
                let href = data.metadata.currentTrack?.albumUri
                for item in realm.objects(MyAlbum.self) {
                    if item.name != albumName {
                        itemAlbum.name = albumName
                        itemAlbum.href = href
                    } else {
                        realm.delete(item)
                        print("Delete ----------------")
                    }
                }
                realm.add(itemAlbum)
            }
        } catch {
            print("Error with Realm----------")
        }
    }
}
