//
//  JazzMusicViewController.swift
//  MyApp
//
//  Created by Tran Dinh Nhan on 6/18/18.
//  Copyright © 2018 Nhan Tran. All rights reserved.
//

import UIKit
import SVProgressHUD

class JazzMusicViewController: UIViewController {

    @IBOutlet weak var imageBackground: UIImageView!
    @IBOutlet weak var listJazzMusicTableView: UITableView!
    @IBOutlet weak var nameCategorySong: UILabel!
    var viewModel = JazzMusicViewModel()
    var imageBG: UIImage?
    var nameTrending: String = ""
    fileprivate var isLoading = false
    // Variables player
    var player: SPTAudioStreamingController?

    override func viewDidLoad() {
        super.viewDidLoad()
        cofigTableViewTrendingSong()
        updateView()
        setNavigationbar()
    }

    func setNavigationbar() {
        navigationController?.isNavigationBarHidden = true
    }

    private func updateView() {
        self.imageBackground.image = imageBG
    }

    private func cofigTableViewTrendingSong() {
        let nib = UINib(nibName: App.String.trendingSongJazz, bundle: Bundle.main)
        listJazzMusicTableView.register(nib, forCellReuseIdentifier: App.String.trendingSongJazz)
        listJazzMusicTableView.delegate = self
        listJazzMusicTableView.dataSource = self
        listJazzMusicTableView.backgroundColor = UIColor.clear
        refresh()
    }

    func refresh() {
        if isLoading { return }
        isLoading = true
        SVProgressHUD.show()
        viewModel.refresh { [weak self] (result) in
            guard let this = self else { return }
            switch result {
            case .success:
                this.listJazzMusicTableView.reloadData()
                this.isLoading = false
            case .failure: break
            }
            SVProgressHUD.dismiss()
        }
    }

    @IBAction func shufflePlayButton(_ sender: Any) {
    }

    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        navigationController?.isNavigationBarHidden = false
    }
}

extension JazzMusicViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let navi = ScreenPlayerSongViewController()
        navi.viewModel = viewModel.viewModelForPlaySong(at: indexPath)
        navi.viewModel?.indexSelected = indexPath.row
        present(navi, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
}

extension JazzMusicViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = listJazzMusicTableView.dequeueReusableCell(withIdentifier: App.String.trendingSongJazz, for: indexPath) as? JazzMusicTableViewCell else { fatalError() }
        cell.viewModel = viewModel.cellForRowAtTrendingSongList(at: indexPath)
        cell.backgroundColor = UIColor.clear
        return cell
    }
}
