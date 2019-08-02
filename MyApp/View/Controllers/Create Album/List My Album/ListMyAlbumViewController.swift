//
//  ListMyAlbumViewController.swift
//  MyApp
//
//  Created by Tran Dinh Nhan on 6/28/18.
//  Copyright © 2018 Nhan Tran. All rights reserved.
//

import UIKit

class ListMyAlbumViewController: UIViewController {
    @IBOutlet weak var imageBackgound: UIImageView!
    @IBOutlet weak var tableListSongView: UITableView!
    @IBOutlet weak var albumName: UILabel!
    var viewModel = ListMyAlbumViewModel()
    fileprivate var isLoading = false

    override func viewDidLoad() {
        super.viewDidLoad()
        configTableCell()
        albumName.text = viewModel.name ?? ""
    }

    private func configTableCell() {
        let nib = UINib(nibName: App.String.listMyAlbum, bundle: Bundle.main)
        tableListSongView.register(nib, forCellReuseIdentifier: App.String.listMyAlbum)
        tableListSongView.delegate = self
        tableListSongView.dataSource = self
        tableListSongView.backgroundColor = UIColor.clear
        refreshListAlbum()
    }

    private func refreshListAlbum() {
//        guard let viewModel = viewModel else { return }
        viewModel.refresh { [weak self] (result) in
            guard let this = self else { return }
            switch result {
            case .success:
                this.tableListSongView.reloadData()
                this.isLoading = false
            case .failure: break
            }
        }
    }

    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true)
    }
}

extension ListMyAlbumViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return viewModel.numberOfRowsInSection()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableListSongView.dequeueReusableCell(withIdentifier: App.String.listMyAlbum, for: indexPath) as? ListMyAlbumTableViewCell else { fatalError() }
        cell.viewModel = viewModel.cellForRowAtListMyAlbum(at: indexPath)
        cell.backgroundColor = UIColor.clear
        return cell
    }
}

extension ListMyAlbumViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let navi = ScreenPlayerSongViewController()
        navi.viewModel = viewModel.viewModelForPlaySong(at: indexPath)
        navi.viewModel?.indexSelected = indexPath.row
        present(navi, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
