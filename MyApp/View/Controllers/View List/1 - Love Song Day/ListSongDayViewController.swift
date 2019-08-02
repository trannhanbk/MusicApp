//
//  ListSongDayViewController.swift
//  MyApp
//
//  Created by Tran Dinh Nhan on 6/6/18.
//  Copyright © 2018 Nhan Tran. All rights reserved.
//

import UIKit
import SVProgressHUD

class ListSongDayViewController: UIViewController {

    @IBOutlet weak var imageSongDay: UIImageView!
    @IBOutlet weak var imageBGround: UIImageView!
    @IBOutlet weak var nameSongDay: UILabel!
    @IBOutlet weak var listSongDayTableView: UITableView!
    var viewModel: ListSongDayViewModel?
    var imageLoveSongDay: UIImage?
    var nameLoveSongDay: String = ""
    fileprivate var isLoading = false

    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        navigationController?.isNavigationBarHidden = true
        updateScreenView()
    }

    private func updateScreenView() {
        guard let viewModel = viewModel else { return }
        imageBGround.sd_setImage(with: URL(string: viewModel.image))
        nameSongDay.text = viewModel.name
    }

    private func configTableView() {
        let topSong = UINib(nibName: App.String.listSongDay, bundle: Bundle.main)
        listSongDayTableView.register(topSong, forCellReuseIdentifier: App.String.listSongDay)
        listSongDayTableView.delegate = self
        listSongDayTableView.dataSource = self
        listSongDayTableView.backgroundColor = UIColor.clear
        refreshLoveSongDay()
    }

    private func refreshLoveSongDay () {
        guard let viewModel = viewModel else { return }
        SVProgressHUD.show()
        viewModel.refresh { [weak self] (result) in
            guard let this = self else { return }
            switch result {
            case .success:
                this.listSongDayTableView.reloadData()
                this.isLoading = false
            case .failure: break
            }
            SVProgressHUD.dismiss()
        }
    }

    @IBAction func playSongButton(_ sender: Any) {
        let playSong = ScreenPlayerSongViewController()
        playSong.viewModel = viewModel?.actionPlaySong()
        present(playSong, animated: true)
    }

    @IBAction func backToHomeButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        navigationController?.isNavigationBarHidden = false
    }
}

extension ListSongDayViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.numberOfRowsInSection()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = listSongDayTableView.dequeueReusableCell(withIdentifier: App.String.listSongDay, for: indexPath) as? ListSongDayTableCell else { fatalError() }
        guard let viewModel = viewModel else { fatalError() }
        cell.viewModel = viewModel.cellForRowAtLoveSongDay(at: indexPath)
        cell.backgroundColor = UIColor.clear
        return cell
    }
}

extension ListSongDayViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let navi = ScreenPlayerSongViewController()
        navi.viewModel = viewModel?.viewModelForPlaySong(at: indexPath)
        navi.viewModel?.indexSelected = indexPath.row
        present(navi, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
}
