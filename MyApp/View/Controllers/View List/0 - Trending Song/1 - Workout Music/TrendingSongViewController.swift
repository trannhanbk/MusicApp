//
//  TrendingSongViewController.swift
//  MyApp
//
//  Created by Tran Dinh Nhan on 6/6/18.
//  Copyright © 2018 Nhan Tran. All rights reserved.
//

import UIKit
import AVFoundation
import SVProgressHUD

class TrendingSongViewController: UIViewController {

    @IBOutlet weak var imageBackground: UIImageView!
    @IBOutlet weak var nameTrendingSong: UILabel!
    @IBOutlet weak var nameCategory: UILabel!
    @IBOutlet weak var listTrendingSong: UITableView!
    var viewModel = TrendingSongViewModel()
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
        self.nameTrendingSong.text = nameTrending
//        self.nameCategory.text = nameTrending
    }

    private func cofigTableViewTrendingSong() {
        let nib = UINib(nibName: App.String.trendingSong, bundle: Bundle.main)
        listTrendingSong.register(nib, forCellReuseIdentifier: App.String.trendingSong)
        listTrendingSong.delegate = self
        listTrendingSong.dataSource = self
        listTrendingSong.backgroundColor = UIColor.clear
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
                this.listTrendingSong.reloadData()
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
    @IBAction func shufflePlayButton(_ sender: Any) {
    }
}

extension TrendingSongViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let navi = PlayerViewController()
        navi.viewModel = viewModel.viewModelForPlaySong(at: indexPath)
        navi.viewModel?.indexSelected = indexPath.row
        present(navi, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
}

extension TrendingSongViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = listTrendingSong.dequeueReusableCell(withIdentifier: App.String.trendingSong, for: indexPath) as? TrendingSongTableViewCell else { fatalError() }
        cell.viewModel = viewModel.cellForRowAtTrendingSongList(at: indexPath)
        cell.backgroundColor = UIColor.clear
        return cell
    }
}
