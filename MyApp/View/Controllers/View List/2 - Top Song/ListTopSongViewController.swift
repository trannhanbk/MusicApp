//
//  ListTopSongViewController.swift
//  MyApp
//
//  Created by Tran Dinh Nhan on 6/6/18.
//  Copyright © 2018 Nhan Tran. All rights reserved.
//

import UIKit
import SVProgressHUD

class ListTopSongViewController: UIViewController {

    @IBOutlet weak var listTopSongTableView: UITableView!
    @IBOutlet weak var imageTopSong: UIImageView!
    private var viewModel = ListTopSongViewModel()
    fileprivate var isLoading = false

    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigationBar()
        configTableViewTopSong()
        refresh()
    }

    private func configNavigationBar() {
        navigationController?.isNavigationBarHidden = true
    }

    private func configTableViewTopSong() {
        let topSong = UINib(nibName: App.String.listTopSong, bundle: Bundle.main)
        listTopSongTableView.register(topSong, forCellReuseIdentifier: App.String.listTopSong)
        listTopSongTableView.delegate = self
        listTopSongTableView.dataSource = self
        listTopSongTableView.backgroundColor = UIColor.clear
    }

    private func refresh() {
        if isLoading { return }
        isLoading = true
        SVProgressHUD.show()
        viewModel.refresh { [weak self] (result) in
            guard let this = self else { return }
            switch result {
            case .success:
                this.listTopSongTableView.reloadData()
                this.isLoading = false
            case .failure: break
            }
            SVProgressHUD.dismiss()
        }
    }

    @IBAction func backToHomeButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        navigationController?.isNavigationBarHidden = false
    }
}

extension ListTopSongViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSectionTopSong()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = listTopSongTableView.dequeueReusableCell(withIdentifier: App.String.listTopSong, for: indexPath) as? TopSongTableCell else { fatalError() }
        cell.viewModel = viewModel.cellForRowAtTopSongList(at: indexPath)
        cell.backgroundColor = UIColor.clear
        return cell
    }
}

extension ListTopSongViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let navi = ScreenPlayerSongViewController()
        navi.viewModel = viewModel.viewModelForPlaySong(at: indexPath)
        navi.viewModel?.indexSelected = indexPath.row
        present(navi, animated: true)
    }
}
