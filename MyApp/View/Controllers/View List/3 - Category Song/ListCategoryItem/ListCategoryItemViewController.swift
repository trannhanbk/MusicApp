//
//  ListCategoryItemViewController.swift
//  MyApp
//
//  Created by Tran Dinh Nhan on 6/6/18.
//  Copyright © 2018 Nhan Tran. All rights reserved.
//

import UIKit
import SVProgressHUD

class ListCategoryItemViewController: UIViewController {

    @IBOutlet weak var imageBackground: UIImageView!
    @IBOutlet weak var nameCategory: UILabel!
    @IBOutlet weak var listSongTableView: UITableView!

    var viewModel: ListCategoryItemViewModel?
    fileprivate var isLoading = false

    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        navigationController?.isNavigationBarHidden = true
        updateView()
    }

    private func updateView() {
        guard let viewModel = viewModel else { return }
        imageBackground.sd_setImage(with: URL(string: viewModel.image))
        nameCategory.text = viewModel.name
    }

    private func configTableView() {
        let nib = UINib(nibName: App.String.listCategoryItem, bundle: Bundle.main)
        listSongTableView.register(nib, forCellReuseIdentifier: App.String.listCategoryItem)
        listSongTableView.delegate = self
        listSongTableView.dataSource = self
        listSongTableView.backgroundColor = UIColor.clear
        refreshCategorySongDay()
    }

    func configureData(item: Item) {
        if let urlThumb = item.image?.first?.url {
            imageBackground.sd_setImage(with: URL(string: urlThumb))
            imageBackground.layer.cornerRadius = 10
            imageBackground.clipsToBounds = true
        }
        nameCategory.text = item.name
    }

    private func refreshCategorySongDay () {
        guard let viewModel = viewModel else { return }
        SVProgressHUD.show()
        viewModel.refresh { [weak self] (result) in
            guard let this = self else { return }
            switch result {
            case .success:
                this.listSongTableView.reloadData()
                this.isLoading = false
            case .failure: break
            }
            SVProgressHUD.dismiss()
        }
    }

    @IBAction func backToHomeButton(_ sender: Any) {
        navigationController?.isNavigationBarHidden = false
        navigationController?.popViewController(animated: true)
    }

    @IBAction func shufflePlayButton(_ sender: Any) {
        let playSong = ScreenPlayerSongViewController()
        playSong.viewModel = viewModel?.actionPlaySong()
        present(playSong, animated: true)
    }
}

extension ListCategoryItemViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.numberOfRowsInSection()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = listSongTableView.dequeueReusableCell(withIdentifier: App.String.listCategoryItem, for: indexPath) as? ListCategorySongTableCell else { fatalError() }
        guard let viewModel = viewModel else { fatalError() }
        cell.viewModel = viewModel.cellForRowAtTrendingSongList(at: indexPath)
        cell.backgroundColor = UIColor.clear
        return cell
    }
}

extension ListCategoryItemViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let playSong = ScreenPlayerSongViewController()
        playSong.viewModel = viewModel?.viewModelForPlaySong(at: indexPath)
        playSong.viewModel?.indexSelected = indexPath.row
        present(playSong, animated: true)
    }
}
