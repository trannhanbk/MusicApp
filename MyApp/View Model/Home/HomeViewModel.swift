//
//  HomeViewModel.swift
//  MyApp
//
//  Created by Tran Dinh Nhan on 5/27/18.
//  Copyright © 2018 Nhan Tran. All rights reserved.
//

import UIKit

class HomeViewModel {
    let title = App.String.Home

    var categoriesData: [Categories] = {
        return Categories.initCategories()
    }()

    var categoriesTrendingSong: [CategoryTrendingSong] = {
        return CategoryTrendingSong.initCategoryTrendingSong()
    }()

    var listCategoryItemData: [Categories] = {
        return Categories.initCategories()
    }()

    var songData: [Song] = []

    enum HomeCollectionView: Int {
        case trendingSong
        case amlbumHot
    }

    enum TrendingSong: Int {
        case workoutMusic
        case kpop
        case edmDance
        case folkMusic
        case jazz
        var title: String {
            switch self {
            case .workoutMusic:
                return "Workout Music"
            case .kpop:
                return "K-POP"
            case .edmDance:
                return "EDM - Dance"
            case .folkMusic:
                return "Folk Music"
            case .jazz:
                return "Jazz"
            }
        }
        static var menus: [TrendingSong] = {
            var max = 0
            var menus: [TrendingSong] = []
            while let item = TrendingSong(rawValue: max) {
                max += 1
                menus.append(item)
            }
            return menus
        }()
    }

    enum Section: Int {
        case loveDaySong
        case topSong
        case youCanLike
        case categorySong
        var title: String {
            switch self {
            case .loveDaySong:
                return "TUẦN MỚI TĂNG ĐỘNG?"
            case .topSong:
                return "LIST OF NEW RELEASES"
            case .youCanLike:
                return "CÓ THỂ BẠN THÍCH"
            case .categorySong:
                return "CHỦ ĐỀ VÀ THỂ LOẠI"
            }
        }

        static var menus: [Section] = {
            var max = 0
            var menus: [Section] = []
            while let item = Section(rawValue: max) {
                max += 1
                menus.append(item)
            }
            return menus
        }()
    }

    func numberOfRowsInSectionTrendingSong() -> Int {
        return TrendingSong.menus.count
    }

    func numberOfSections() -> Int {
        return Section.menus.count
    }

    func titleForHeaderInSection(inSection section: Int) -> String? {
        guard let item = Section(rawValue: section) else { return "" }
        return item.title
    }

    func cellForItemAtCategory1(at indexPath: IndexPath) -> HomeCellTrendingSongViewModel {
        let row = indexPath.row
        let name = categoriesTrendingSong[row].name
        let image = categoriesTrendingSong[row].image
        return HomeCellTrendingSongViewModel(imageCategory: image, imageCategorySmall: image, nameCategory: name)
    }

    // Like Song

    enum Result {
        case success
        case failure(Error)
    }

    typealias Completion = (Result) -> Void
    typealias Completion1 = (Result) -> Void
    typealias Completion2 = (Result) -> Void
    typealias Completion3 = (Result) -> Void
    fileprivate var itemsAlbumHotitems: [Item] = []
    fileprivate var itemsAlbum: [ItemAlbum] = []
    fileprivate var items: [Item] = []

    func refresh(completion: @escaping Completion) {
        loadData1(completion: completion)
    }

    func refreshAlbum(completion: @escaping Completion1) {
        loadDataNewrelease(completion: completion)
    }

    // Top Song

    func loadData1(completion: @escaping Completion) {
        let prameters = Api.FeaturedPlaylist.Attribute(country: "VN",
                                                       locale: "VN_VI",
                                                       timestamp: "2018-06-29T09:00:00",
                                                       limit: 12,
                                                       offset: 5)
        Api.FeaturedPlaylist.Attribute.feedDataFeaturedPlaylist(parameters: prameters) { [weak self] (result) in
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

    func numberOfSectionDaySong() -> Int {
        return items.count
    }

    func cellForItemSectionEveryDaySong(at indexPath: IndexPath) -> SongEveryDayCellViewModel {
        return SongEveryDayCellViewModel(item: items[indexPath.row])
    }

    func viewModelForPlaySong(at indexPath: IndexPath) -> PlayerSongViewModel {
        let uri = items[indexPath.row].uri
        let name = items[indexPath.row].name ?? ""
        let imageURL = items[indexPath.row].image?.first?.url ?? ""
        return PlayerSongViewModel(dataPlays: [PlayerSongViewModel.DataPlays(albumName: name, uri: uri, name: name, image: imageURL)])
    }

    func linkTrackHref(at indexPath: IndexPath) -> ListSongDayViewModel {
        let href = items[indexPath.row].tracks?.href ?? ""
        let name = items[indexPath.row].name ?? ""
        let imageURL = items[indexPath.row].image?.first?.url ?? ""
        let uri = items[indexPath.row].uri
        return ListSongDayViewModel(href: href, name: name, image: imageURL, uri: uri)
    }

    // New Release

    func loadDataNewrelease(completion: @escaping Completion) {
        let prameters = Api.NewRelease.Attribute(country: "VN",
                                                limit: 12,
                                                offset: 5)
        Api.NewRelease.Attribute.feedDataFeaturedPlaylistAlbum(parameters: prameters) { [weak self] (result) in
            guard let this = self else { return }
            switch result {
            case .success(let data):
                guard let dataItem = data.albums?.itemAlbums else { return }
                this.itemsAlbum.append(contentsOf: dataItem)
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func numberOfRowInSectionNewRelleases() -> Int {
        return itemsAlbum.count
    }

    func cellForItemSectionNewReleases(at indexPath: IndexPath) -> TopSongCellViewModel {
        return TopSongCellViewModel(item: itemsAlbum[indexPath.row])
    }

    func viewModelForPlaySongAlbumNewReleases(at indexPath: IndexPath) -> PlayerSongViewModel {
        let data = itemsAlbum.map { (item) -> PlayerSongViewModel.DataPlays in
            return PlayerSongViewModel.DataPlays(albumName: item.name,
                                                 uri: item.uri,
                                                 name: item.artist.first?.name ?? "",
                                                 image: item.image?.first?.url ?? "")
        }
        return PlayerSongViewModel(dataPlays: data)
    }

// Album Hot

    typealias Completion4 = (Result) -> Void
    fileprivate var itemsAlbumHot: [Item] = []
    fileprivate var tracks: [Tracks] = []

    func refreshDataAlbumHot(completion: @escaping Completion4) {
        loadDataAlbumHot(completion: completion)
    }

    func loadDataAlbumHot(completion: @escaping Completion6) {
        let prameters = Api.Trending.Attribute(country: "VN",
                                               limit: 20,
                                               offset: 5)
        Api.Trending.Attribute.feeDataTrendingSongEDM(parameters: prameters) { [weak self] (result) in
            guard let this = self else { return }
            switch result {
            case .success(let data):
                guard let dataItem = data.playlist?.item else { return }
                this.itemsAlbumHot.append(contentsOf: dataItem)
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func numberOfRowsInSectionAlbumHot() -> Int {
        return itemsAlbumHot.count
    }

    func cellForRowAtAlbumHot(at indexPath: IndexPath) -> AlbumItemCellViewModel {
        return AlbumItemCellViewModel(item: itemsAlbumHot[indexPath.row])
    }

    func viewModelForAlbumHotSongList(at indexPath: IndexPath) -> AlbumHotViewModel {
        let href = itemsAlbumHot[indexPath.row].tracks?.href ?? ""
        let name = itemsAlbumHot[indexPath.row].name ?? ""
        let imageURL = itemsAlbumHot[indexPath.row].image?.first?.url ?? ""
        let uri = itemsAlbumHot[indexPath.row].uri
        return AlbumHotViewModel(href: href, name: name, image: imageURL, uri: uri)
    }

// Like Song

    typealias Completion5 = (Result) -> Void
    fileprivate var itemsLikeSong: [Item] = []

    func refreshDataLikeSong(completion: @escaping Completion5) {
        loadDataLikeSong(completion: completion)
    }

    func loadDataLikeSong(completion: @escaping Completion5) {
        let prameters = Api.LikeSong.Attribute(country: "SE",
                                               limit: 10,
                                               offset: 5)
        Api.LikeSong.Attribute.feedDataFeaturedPlaylistMusicLike(parameters: prameters) { [weak self] (result) in
            guard let this = self else { return }
            switch result {
            case .success(let data):
                guard let dataItem = data.playlist?.item else { return }
                this.itemsLikeSong.append(contentsOf: dataItem)
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    func numberOfRowsInSectionLikeSong() -> Int {
        return itemsLikeSong.count
    }

    func cellForRowAtTrendingLikeSong(at indexPath: IndexPath) -> LikeSongViewModel {
        return LikeSongViewModel(item: itemsLikeSong[indexPath.row])
    }

    func viewModelForPlayLikeSong(at indexPath: IndexPath) -> PlayerSongViewModel {
        let data = itemsLikeSong.map { (item) -> PlayerSongViewModel.DataPlays in
            return PlayerSongViewModel.DataPlays(albumName: item.name ?? "",
                                                 uri: item.uri,
                                                 name: item.name ?? "",
                                                 image: item.image?.first?.url ?? "")
        }
        return PlayerSongViewModel(dataPlays: data)
    }

// Category Song

    typealias Completion6 = (Result) -> Void
    fileprivate var itemsCategory: [Item] = []

    func refreshCategory(completion: @escaping Completion6) {
        loadDataCategorySong(completion: completion)
    }

    func loadDataCategorySong(completion: @escaping Completion6) {
        let prameters = Api.Trending.Attribute(country: "VN",
                                               limit: 8,
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
}
