//
//  FavoriteSongViewController.swift
//  MyApp
//
//  Created by Tran Dinh Nhan on 6/21/18.
//  Copyright © 2018 Nhan Tran. All rights reserved.
//

import UIKit
import RealmSwift

class FavoriteSongViewController: UIViewController {
    @IBOutlet weak var tableViewFavorite: UITableView!
    var viewModel = FavoriteSongViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableCell()
    }

    @IBAction func closeScreenButton(_ sender: Any) {
        let home = HomeViewController()
        sideMenuController?.rootViewController = UINavigationController(rootViewController: home)
    }

    @IBAction func deleteCellButton(_ sender: Any) {
        let alert = UIAlertController(title: "★★★★★ HELLO ★★★★★", message: "Do you want delete all song in favorite playlist?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style {
            case .default:
                do {
                    let realm = try Realm()
                    try realm.write {
                        let items = realm.objects(FavoriteSong.self)
                        realm.delete(items)
                    }
                } catch {
                    print("Delete")
                }
                self.tableViewFavorite.reloadData()
            case .cancel:
                break
            case .destructive:
                break
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    private func configTableCell() {
        let nib = UINib(nibName: App.String.favoriteCell, bundle: Bundle.main)
        tableViewFavorite.register(nib, forCellReuseIdentifier: App.String.favoriteCell)
        tableViewFavorite.delegate = self
        tableViewFavorite.dataSource = self
        tableViewFavorite.backgroundColor = UIColor.clear
    }
}

extension FavoriteSongViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let player = ScreenPlayerSongViewController()
        player.viewModel = viewModel.viewModelForPlaySongAlbumNewReleases(at: indexPath)
        present(player, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension FavoriteSongViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableViewFavorite.dequeueReusableCell(withIdentifier: App.String.favoriteCell, for: indexPath) as? FavoriteTableViewCell else { fatalError() }
        do {
            let realm = try Realm()
            cell.updateCell(data: realm.objects(FavoriteSong.self)[indexPath.row + 1])
        } catch {
            print("Error Realm-----------")
        }
        cell.backgroundColor = UIColor.clear
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        viewModel.editingStyle(tableViewFavorite, commit: editingStyle, forRowAt: indexPath)
    }
}
