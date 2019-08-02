//
//  FavoriteSong.swift
//  MyApp
//
//  Created by Tran Dinh Nhan on 6/21/18.
//  Copyright © 2018 Nhan Tran. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers final class FavoriteSong: Object {
//    dynamic var href: String?
    dynamic var uri: String?
    dynamic var name: String?
    dynamic var image: String?
    dynamic var title: String?
}

@objcMembers final class MyAlbum: Object {
    dynamic var name: String?
    dynamic var href: String?
}
