//
//  AlbumHotListViewController.swift
//  MyApp
//
//  Created by Tran Dinh Nhan on 6/25/18.
//  Copyright © 2018 Nhan Tran. All rights reserved.
//

import UIKit
import SVProgressHUD

class AlbumHotListViewController: UIViewController {
    @IBOutlet private weak var nameAlbumHot: UILabel!
    @IBOutlet weak var imageBackgroud: UIImageView!
    @IBOutlet private weak var tableViewAlbumHot: UITableView!
    var viewModel: AlbumHotViewModel?
    fileprivate var isLoading = false

    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        updateView()
        navigationController?.isNavigationBarHidden = true
    }

    func updateView() {
        guard let viewModel = viewModel else { return }
        nameAlbumHot.text = viewModel.name
        imageBackgroud.sd_setImage(with: URL(string: viewModel.image))
        imageBackgroud.layer.cornerRadius = 10
        imageBackgroud.clipsToBounds = true
    }

    private func configTableView() {
        let nib = UINib(nibName: App.String.albumHotCell, bundle: Bundle.main)
        tableViewAlbumHot.register(nib, forCellReuseIdentifier: App.String.albumHotCell)
        tableViewAlbumHot.delegate = self
        tableViewAlbumHot.dataSource = self
        tableViewAlbumHot.backgroundColor = UIColor.clear
        refreshCategorySongDay()
    }

    private func refreshCategorySongDay() {
        guard let viewModel = viewModel else { return }
        SVProgressHUD.show()
        viewModel.refresh { [weak self] (result) in
            guard let this = self else { return }
            switch result {
            case .success:
                this.tableViewAlbumHot.reloadData()
                this.isLoading = false
            case .failure: break
            }
            SVProgressHUD.dismiss()
        }
    }

    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        navigationController?.isNavigationBarHidden = false
    }
    @IBAction func playButton(_ sender: Any) {
        let navi = ScreenPlayerSongViewController()
        navi.viewModel = viewModel?.actionPlaySong()
        present(navi, animated: true)
    }
}

extension AlbumHotListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.numberOfRowsInSection()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableViewAlbumHot.dequeueReusableCell(withIdentifier: App.String.albumHotCell, for: indexPath) as? SongAlbumHotViewCell else { fatalError() }
        cell.viewModel = viewModel?.cellForRowAtTrendingAlbumTop(at: indexPath)
        cell.backgroundColor = UIColor.clear
        return cell
    }
}

extension AlbumHotListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let navi = ScreenPlayerSongViewController()
        navi.viewModel = viewModel?.viewModelForPlaySong(at: indexPath)
        navi.viewModel?.indexSelected = indexPath.row
        present(navi, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
