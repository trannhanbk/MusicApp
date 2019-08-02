//  SearchViewController.swift
//  MyApp
//
//  Created by Tran Dinh Nhan on 5/28/18.
//  Copyright © 2018 Nhan Tran. All rights reserved.
//

import UIKit
protocol SearchViewControllerDataSource: class {
    func view(for viewController: SearchViewController) -> [ItemSearch]
}

class SearchViewController: BaseViewController {

    @IBOutlet weak var searchView: UIView!
    @IBOutlet fileprivate weak var searchTableView: UITableView!
    private lazy var searchBar = UISearchBar()
    private let viewModel = SearchViewModel()
    var dataSource: SearchViewControllerDataSource?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func setupUI() {
        configNavigationBar()
        configTableView()
        configSearchBar()
        configureData()
    }

    func configureData() {
        guard let data = dataSource?.view(for: self) else { return }
        viewModel.fetchData(data: data)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.isStatusBarHidden = false
    }

    func configNavigationBar() {
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.tintColor = UIColor.green
        navigationController?.navigationBar.backgroundColor = UIColor.clear
    }

    func configSearchBar() {
        let button = UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self])
        button.title = "Huỷ"
        button.tintColor = UIColor.black
        searchBar = UISearchBar(frame: CGRect(x: 0, y: 10, width: UIScreen.main.bounds.width, height: 20))
        searchBar.placeholder = "Tìm kiếm bài hát"
        searchBar.showsCancelButton = true
        searchBar.barTintColor = UIColor.white
        searchBar.tintColor = UIColor.black
        searchBar.sizeToFit()
        searchView.addSubview(searchBar)
        searchView.backgroundColor = UIColor.clear
        searchBar.becomeFirstResponder()
        searchBar.delegate = self
        searchBar.backgroundColor = UIColor.gray
    }

    func configTableView() {
        let cellNib = UINib(nibName: App.String.SearchTableCell, bundle: Bundle.main)
        searchTableView.register(cellNib, forCellReuseIdentifier: App.String.SearchTableCell)
        let headerSuggest = UINib(nibName: App.String.headerSuggestCell, bundle: Bundle.main)
        searchTableView.register(headerSuggest, forCellReuseIdentifier: App.String.headerSuggestCell)
        searchTableView.backgroundColor = UIColor.clear
        searchTableView.dataSource = self
        searchTableView.delegate = self
    }

    func search(keyword: String) {
        viewModel.searchItem(keyword: keyword) { [weak self] (result) in
            guard let this = self else { return }
            switch result {
            case .success:
                this.searchTableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }

    @IBAction func backButtonTouchUpInside(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
        sideMenuController?.leftViewController = MenuViewController()
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        if viewModel.itemSerch.isEmpty {
            search(keyword: searchText)
        } else {
            viewModel.itemSerch.removeAll()
            searchTableView.reloadData()
            search(keyword: searchText)
        }
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        dismiss(animated: true)
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfSpotifyMusic()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = searchTableView.dequeueReusableCell(withIdentifier: App.String.SearchTableCell, for: indexPath) as? SearchTableCell else { fatalError() }
        cell.viewModel = viewModel.cellForRowAtSearchSongList(at: indexPath)
        cell.backgroundColor = UIColor.clear
        return cell
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let playSong = ScreenPlayerSongViewController()
        playSong.viewModel = viewModel.didSelectRowAtPlaySong(at: indexPath)
        playSong.viewModel?.indexSelected = indexPath.row
        present(playSong, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
