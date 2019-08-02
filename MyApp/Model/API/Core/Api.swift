//
//  Api.swift
//  MyApp
//
//  Created by iOSTeam on 2/21/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

final class Api {
    struct Path {
        static let baseURL = "https://api.spotify.com/v1/browse"
        static let baseURL1 = "https://api.spotify.com/v1/albums?"
        static let baseURLSearch = "https://api.spotify.com/v1"
    }

    struct Trending {}
    struct FeaturedPlaylist {}
    struct NewRelease {}
    struct AlbumHot {}
    struct LikeSong {}
    struct ListSong {}
    struct SearchSong {}
}

extension Api.Path {
    struct Category {
        static var category: String { return baseURL / "categories" }
    }

    struct FeaturedPlaylists {
        static var featuredPlaylist: String { return baseURL / "featured-playlists" }
    }

    struct NewRelease {
        static var newRelease: String { return baseURL / "new-releases" }
    }

    struct AlbumHot {
        static var albumHot: String { return baseURL1 }
    }

    struct SearchSuggest {
        static var pathSearchSuggest: String { return baseURLSearch / "search?" }
    }
}

// MARK: - UrlString SearchSuggest
extension Api.Path.SearchSuggest {
    struct Keyword: ApiPath {
        static var path: String { return pathSearchSuggest }
        var urlString: String { return Keyword.path }
    }
}

// API Trending Song

extension Api.Path.Category {
    struct TrendinSongWorkout {
        static var workout: String { return Api.Path.Category.category / "workout" }
    }

    struct TrendingSongKpop {
        static var kpop: String { return Api.Path.Category.category / "kpop" }
    }

    struct TrendingSongEDMDance {
        static var songEDM: String { return Api.Path.Category.category / "edm_dance" }
    }

    struct TrendingSongFolk {
        static var songFolk: String { return Api.Path.Category.category / "roots" }
    }

    struct TrendingSongJazz {
        static var songJazz: String { return Api.Path.Category.category / "jazz" }
    }

    struct LikeSong {
        static var likeSong: String { return Api.Path.Category.category / "romance" }
    }
}

extension Api.Path.Category {
    struct MusicLike: ApiPath {
        static var path: String { return Api.Path.Category.LikeSong.likeSong / "playlists?" }
        var urlString: String { return MusicLike.path }
    }
}

extension Api.Path.Category {
    struct MusicWorkout: ApiPath {
        static var path: String { return Api.Path.Category.TrendinSongWorkout.workout / "playlists?" }
        var urlString: String { return MusicWorkout.path }
    }
}

extension Api.Path.Category {
    struct MusicKP: ApiPath {
        static var path: String { return Api.Path.Category.TrendingSongKpop.kpop / "playlists?" }
        var urlString: String { return MusicKP.path }
    }
}

extension Api.Path.Category {
    struct MusicEDM: ApiPath {
        static var path: String { return Api.Path.Category.TrendingSongEDMDance.songEDM / "playlists?" }
        var urlString: String { return MusicEDM.path }
    }
}

extension Api.Path.Category {
    struct MusicFolk: ApiPath {
        static var path: String { return Api.Path.Category.TrendingSongFolk.songFolk / "playlists?" }
        var urlString: String { return MusicFolk.path }
    }
}

extension Api.Path.Category {
    struct MusicJazz: ApiPath {
        static var path: String { return Api.Path.Category.TrendingSongJazz.songJazz / "playlists?" }
        var urlString: String { return MusicJazz.path }
    }
}

// API Featured Playlists

extension Api.Path.FeaturedPlaylists {
    struct Music: ApiPath {
        static var path: String { return Api.Path.FeaturedPlaylists.featuredPlaylist }
        var urlString: String { return Music.path }
    }
}

extension Api.Path.NewRelease {
    struct Music: ApiPath {
        static var path: String { return Api.Path.NewRelease.newRelease }
        var urlString: String { return Music.path }
    }
}

protocol URLStringConvertible {
    var urlString: String { get }
}

protocol ApiPath: URLStringConvertible {
    static var path: String { get }
}

extension URL: URLStringConvertible {
    var urlString: String { return absoluteString }
}

extension Int: URLStringConvertible {
    var urlString: String { return String(describing: self) }
}

private func / (lhs: URLStringConvertible, rhs: URLStringConvertible) -> String {
    return lhs.urlString + "/" + rhs.urlString
}

extension String: URLStringConvertible {
    var urlString: String { return self }
}

extension CustomStringConvertible where Self: URLStringConvertible {
    var urlString: String { return description }
}
