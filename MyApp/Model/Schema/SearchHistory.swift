//
//  SearchHistory.swift
//  MyApp
//
//  Created by Tran Dinh Nhan on 7/2/18.
//  Copyright © 2018 Nhan Tran. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers final class SearchHistory: Object {
    dynamic var keyword: String = ""
    override static func primaryKey() -> String {
        return "keyword"
    }

    static func query(keyword: String) -> SearchHistory? {
        do {
            let realm = try Realm()
            return realm.object(ofType: SearchHistory.self, forPrimaryKey: keyword)
        } catch {
            print("Not realm ---------")
            fatalError(error.localizedDescription)
        }
    }
}

extension SearchHistory {
    func clean() {
        do {
            let realm = try Realm()
            let item = realm.objects(SearchHistory.self)
            try realm.write {
                realm.delete(item)
            }
        } catch {
            print(error)
        }
    }
}
