//
//  MenuViewController.swift
//  MyApp
//
//  Created by Tran Dinh Nhan on 5/25/18.
//  Copyright © 2018 Nhan Tran. All rights reserved.
//

import UIKit
import LGSideMenuController

class MenuViewController: UIViewController {

    @IBOutlet fileprivate weak var tableView: UITableView!
    var viewModel = MenuViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
    }

    private func configTableView() {
        let cellNib = UINib(nibName: App.String.SideMenuTableCell, bundle: Bundle.main)
        tableView.register(cellNib, forCellReuseIdentifier: App.String.SideMenuTableCell)
        tableView.backgroundColor = UIColor.clear
        tableView.tableHeaderView?.backgroundColor = UIColor.clear
        tableView.dataSource = self
        tableView.delegate = self
    }

    private func changeViewSideMenu(vc: UIViewController) {
        sideMenuController?.rootViewController = vc
        sideMenuController?.hideLeftViewAnimated()
    }
}

extension MenuViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems(inSection: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: App.String.SideMenuTableCell, for: indexPath) as? SideMenuCell else { fatalError(App.String.ErrorCell) }
        cell.viewModel = viewModel.cellForRowAtSideMenu(at: indexPath)
        cell.backgroundColor = UIColor.clear
        cell.selectionStyle = .gray
        return cell
    }
}

extension MenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = MenuViewModel.Row(rawValue: indexPath.row) {
            switch item {
            case .home: break
            case .favoriteList:
                let favorite = FavoriteViewController()
                self.changeViewSideMenu(vc: favorite)
            case .createAlbum:
                let album = CreateAlbumViewController()
                self.changeViewSideMenu(vc: album)
            case .logOut: break
            }
        }
    }
}
