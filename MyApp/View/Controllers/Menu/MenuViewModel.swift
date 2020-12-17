//
//  SideMenuViewModel.swift
//  MyApp
//
//  Created by Tran Dinh Nhan on 5/27/18.
//  Copyright © 2018 Nhan Tran. All rights reserved.
//

import UIKit
class MenuViewModel {
    enum Section: Int {
        case home

        var items: [Row] {
            switch self {
            case .home: return [.home, .favoriteList, .createAlbum, .logOut]
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

    enum Row: Int {
        case home
        case favoriteList
        case createAlbum
        case logOut
        var title: String {
            switch self {
            case .home:
                return "TRANG CHỦ"
            case .favoriteList:
                return "DANH SÁCH YÊU THÍCH"
            case .createAlbum:
                return "AlBUM"
            case .logOut:
                return "ĐĂNG XUẤT"
            }
        }
    }

    func numberOfItems(inSection section: Int) -> Int {
        guard let item = Section(rawValue: section) else {
            return 0
        }
        return item.items.count
    }

    func numberOfSections() -> Int {
        return 1
    }

    func cellForRowAtSideMenu(at indexPath: IndexPath) -> SideMenuCellVM {
        if let item = Section(rawValue: indexPath.section), item.items.count > indexPath.row {
            let title = item.items[indexPath.row].title
            return SideMenuCellVM(title: title)
        }
        return SideMenuCellVM(title: "")
    }
}
