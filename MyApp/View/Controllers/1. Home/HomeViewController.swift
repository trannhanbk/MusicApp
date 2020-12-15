//
//  HomeViewController.swift
//  MyApp
//
//  Created by Tran Dinh Nhan on 5/25/18.
//  Copyright © 2018 Nhan Tran. All rights reserved.
//

import UIKit
import SVProgressHUD

class HomeViewController: BaseViewController {
    @IBOutlet var collectionViewTrendingSong: UICollectionView!
    @IBOutlet weak var homeTableView: UITableView!
    @IBOutlet weak var collectionViewCategorySong: UICollectionView!
    @IBOutlet weak var collectionViewAlbumHot: UICollectionView!
    @IBOutlet weak var viewFooter: UIView!
    private var timer = Timer()
    private var scrollInterval: Int = 3
    fileprivate var isLoading = false
    var viewModel = HomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configCollectionView()
        configTableViewCell()
//        view.addSubview(addCurrentView())
        homeTableView.backgroundColor = UIColor.clear
        refresh()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(actionPlaySongCategory),
                                               name: NSNotification.Name(rawValue: "SelecPlaySong"),
                                               object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configView()
    }

    private func configView() {
        navigationController?.navigationBar.isHidden = false
        navigationItem.hidesBackButton = false
    }

    @objc func actionPlaySongCategory(_ notification: Notification) {
        if let item = notification.userInfo?["Items"] as? ItemPlayer {
            let navi = ListCategoryItemViewController()
            navi.viewModel = ListCategoryItemViewModel(href: item.href, name: item.name, image: item.image, uri: item.uri)
            navigationController?.pushViewController(navi, animated: true)
        }
    }

    private func configCollectionView() {
        configCategoryCell()
        configCollectionCellFooter()
        startScrolling()
    }

    private func configCategoryCell() {
        let nib = UINib(nibName: App.String.nibName, bundle: Bundle.main)
        collectionViewTrendingSong.register(nib, forCellWithReuseIdentifier: App.String.nibName)
        collectionViewTrendingSong.isPagingEnabled = true
        collectionViewTrendingSong.dataSource = self
        collectionViewTrendingSong.delegate = self
        collectionViewTrendingSong.backgroundColor = UIColor.clear
        collectionViewTrendingSong.backgroundView = UIView(frame: CGRect.zero)
    }

    private func configCollectionCellFooter() {
        let nib = UINib(nibName: "AlbumHotItem", bundle: Bundle.main)
        collectionViewAlbumHot.register(nib, forCellWithReuseIdentifier: "AlbumHotItem")
        collectionViewAlbumHot.delegate = self
        collectionViewAlbumHot.dataSource = self
        collectionViewAlbumHot.backgroundColor = UIColor.clear
        viewFooter.backgroundColor = UIColor.clear
    }

    @IBAction func viewMoreCategorySongButton(_ sender: Any) {
        let listCategory = ListCategorySongViewController()
        navigationController?.pushViewController(listCategory, animated: true)
    }
    private func configTableViewCell() {
        configureTableView()
    }

    private func registerCell(nibName: String, forCellReuseIdentifier identifier: String) {
        let nib = UINib(nibName: nibName, bundle: Bundle.main)
        homeTableView.register(nib, forCellReuseIdentifier: identifier)
    }

    private func configureTableView() {
        registerCell(nibName: App.String.likeSong, forCellReuseIdentifier: App.String.likeSong)
        registerCell(nibName: "CategorySongTableCell", forCellReuseIdentifier: "CategorySongTableCell")
        registerCell(nibName: App.String.categoryCell, forCellReuseIdentifier: App.String.categoryCell)
        registerCell(nibName: App.String.topSongTableViewCell, forCellReuseIdentifier: App.String.topSongTableViewCell)
        registerCell(nibName: App.String.songEveryDayTableViewCell, forCellReuseIdentifier: App.String.songEveryDayTableViewCell)
        homeTableView.delegate = self
        homeTableView.dataSource = self
        homeTableView.backgroundColor = UIColor.clear
    }

    private func refresh() {
        if isLoading { return }
        isLoading = true
        SVProgressHUD.show()
        refreshTrendingSong()
        refreshAlbum()
        refreshCategorySong()
        refreshLikeSong()
        refreshAlbumHot()
    }

    private func refreshTrendingSong () {
        viewModel.refresh { [weak self] (result) in
            guard let this = self else { return }
            switch result {
            case .success:
                this.homeTableView.reloadData()
                this.isLoading = false
            case .failure: break
            }
            SVProgressHUD.dismiss()
        }
    }

    private func refreshAlbum() {
        viewModel.refreshAlbum { [weak self] (result) in
            guard let this = self else { return }
            switch result {
            case .success:
                this.homeTableView.reloadData()
                this.isLoading = false
            case .failure: break
            }
            SVProgressHUD.dismiss()
        }
    }

    private func refreshCategorySong() {
        viewModel.refreshCategory { [weak self] (result) in
            guard let this = self else { return }
            switch result {
            case .success:
                this.homeTableView.reloadData()
                this.isLoading = false
            case .failure: break
            }
            SVProgressHUD.dismiss()
        }

    }

    private func refreshLikeSong() {
        viewModel.loadDataLikeSong { [weak self] (result) in
            guard let this = self else { return }
            switch result {
            case .success:
                this.homeTableView.reloadData()
                this.isLoading = false
            case .failure: break
            }
            SVProgressHUD.dismiss()
        }
    }

    private func refreshAlbumHot() {
        viewModel.refreshDataAlbumHot { [weak self] (result) in
            guard let this = self else { return }
            switch result {
            case .success:
                this.collectionViewAlbumHot.reloadData()
                this.isLoading = false
            case .failure: break
            }
            SVProgressHUD.dismiss()
        }
    }

    private func setTimer() {
        timer = Timer.scheduledTimer(timeInterval: TimeInterval(scrollInterval), target: self, selector: #selector(autoScrollImageSlider), userInfo: nil, repeats: true)
//        RunLoop.main.add(self.timer, forMode: .RunLoop.Mode.common)
        RunLoop.main.add(self.timer, forMode: .common)
    }

    @objc private func autoScrollImageSlider() {
        DispatchQueue.main.async {
            let firstIndex = 0
            let lastIndex = self.collectionViewTrendingSong.numberOfItems(inSection: 0) - 1
            let visibleCellsIndexes = self.collectionViewTrendingSong.indexPathsForVisibleItems.sorted()
            if !visibleCellsIndexes.isEmpty {
                let nextIndex = visibleCellsIndexes[0].row + 1
                let nextIndexPath: IndexPath = IndexPath(item: nextIndex, section: 0)
                let firstIndexPath: IndexPath = IndexPath(item: firstIndex, section: 0)
                if nextIndex > lastIndex {
                    self.collectionViewTrendingSong.scrollToItem(at: firstIndexPath, at: .centeredHorizontally, animated: true)
                } else {
                    self.collectionViewTrendingSong.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
                }
            }
        }
    }

    private func startScrolling() {
        if !timer.isValid {
            if self.collectionViewTrendingSong.numberOfItems(inSection: 0) != 0 {
                stopScrolling()
                setTimer()
            }
        }
    }

    private func stopScrolling() {
        if timer.isValid { self.timer.invalidate() }
    }

    private func configNavigation() {
        title = viewModel.title
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "icons8-menu-filled-50").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(showSideMenu))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "icons8-search-filled-50").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(pushToSearchView))
        navigationController?.navigationBar.barTintColor = UIColor.white
    }

    @objc private func showSideMenu() {
        sideMenuController?.showLeftView(animated: true, completionHandler: nil)
    }

    @objc private func pushToSearchView() {
        let vc = SearchViewController()
        present(vc, animated: true)
    }
}

extension HomeViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionViewTrendingSong {
            return viewModel.numberOfRowsInSectionTrendingSong()
        } else if collectionView == self.collectionViewAlbumHot {
            return viewModel.numberOfRowsInSectionAlbumHot()
        } else {
            return viewModel.numberOfRowsInSectionCategorySong()
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionViewTrendingSong {
            guard let cell = collectionViewTrendingSong.dequeueReusableCell(withReuseIdentifier: App.String.nibName, for: indexPath) as? TrendingSongViewCell else {
                fatalError()
            }
            cell.backgroundColor = UIColor.clear
            cell.viewModel = viewModel.cellForItemAtCategory1(at: indexPath)
            return cell
        } else {
            guard let cell = collectionViewAlbumHot.dequeueReusableCell(withReuseIdentifier: "AlbumHotItem", for: indexPath) as? AlbumHotItem else { fatalError() }
            cell.backgroundColor = UIColor.clear
            cell.viewModel = viewModel.cellForRowAtAlbumHot(at: indexPath)
            return cell
        }
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.collectionViewTrendingSong {
            return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
        } else if collectionView == self.collectionViewAlbumHot {
            return CGSize(width: collectionView.frame.size.width / 2, height: 180)
        } else {
            return CGSize(width: 200, height: 100)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.collectionViewTrendingSong {
                if let item = HomeViewModel.TrendingSong(rawValue: indexPath.row) {
                    switch item {
                    case .workoutMusic:
                        let trendingSong = TrendingSongViewController()
                        trendingSong.imageBG = viewModel.categoriesTrendingSong[indexPath.row].image
                        trendingSong.nameTrending = viewModel.categoriesTrendingSong[indexPath.row].name
                        navigationController?.pushViewController(trendingSong, animated: true)
                    case .kpop:
                        let trendingSongKpop = TrendingSongKpopViewController()
                        trendingSongKpop.imageBG = viewModel.categoriesTrendingSong[indexPath.row].image
                        trendingSongKpop.nameTrending = viewModel.categoriesTrendingSong[indexPath.row].name
                        navigationController?.pushViewController(trendingSongKpop, animated: true)
                    case .edmDance:
                        let trendingSongEDM = TrendingSongEDMDanceViewController()
                        trendingSongEDM.imageBG = viewModel.categoriesTrendingSong[indexPath.row].image
                        trendingSongEDM.nameTrending = viewModel.categoriesTrendingSong[indexPath.row].name
                        navigationController?.pushViewController(trendingSongEDM, animated: true)
                    case .folkMusic:
                        let trendingSongFolk = FolkMusicViewController()
                        trendingSongFolk.imageBG = viewModel.categoriesTrendingSong[indexPath.row].image
                        trendingSongFolk.nameTrending = viewModel.categoriesTrendingSong[indexPath.row].name
                        navigationController?.pushViewController(trendingSongFolk, animated: true)
                    case .jazz:
                        let trendingSongJazz = JazzMusicViewController()
                        trendingSongJazz.imageBG = viewModel.categoriesTrendingSong[indexPath.row].image
                        trendingSongJazz.nameTrending = viewModel.categoriesTrendingSong[indexPath.row].name
                        navigationController?.pushViewController(trendingSongJazz, animated: true)
                    }
                }
        } else if collectionView == self.collectionViewAlbumHot {
                let navi = AlbumHotListViewController()
                navi.viewModel = viewModel.viewModelForAlbumHotSongList(at: indexPath)
                navigationController?.pushViewController(navi, animated: true)
        } else {
            let navi = ListCategoryItemViewController()
            navigationController?.pushViewController(navi, animated: true)
        }
    }
}

// Table view:

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = HomeViewModel.Section(rawValue: indexPath.section) {
            switch item {
            case .loveDaySong:
                let navi = ListSongDayViewController()
                navi.viewModel = viewModel.linkTrackHref(at: indexPath)
                navigationController?.pushViewController(navi, animated: true)
            case .topSong:
                let navi = ScreenPlayerSongViewController()
                navi.viewModel = viewModel.viewModelForPlaySongAlbumNewReleases(at: indexPath)
                navi.viewModel?.indexSelected = indexPath.row
                present(navi, animated: true)
            case .youCanLike:
                let navi = ScreenPlayerSongViewController()
                navi.viewModel = viewModel.viewModelForPlayLikeSong(at: indexPath)
                present(navi, animated: true)
            case .categorySong:
                let navi = ListCategoryItemViewController()
                navigationController?.pushViewController(navi, animated: true)
            }
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let section = HomeViewModel.Section(rawValue: indexPath.section) {
            switch section {
            case .loveDaySong: return 90
            case .topSong: return 60
            case .youCanLike: return 60
            case .categorySong: return 100
            }
        }
        return 0
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if let section = HomeViewModel.Section(rawValue: section) {
            switch section {
            case .topSong, .categorySong, .youCanLike: return 50
            default: return 0
            }
        }
        return 0
    }
}

extension HomeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let section = HomeViewModel.Section(rawValue: section) {
            switch section {
            case .youCanLike:
                return viewModel.numberOfRowsInSectionLikeSong()
            case .topSong:
                return viewModel.numberOfRowInSectionNewRelleases()
            case .loveDaySong:
                return viewModel.numberOfSectionDaySong()
            case .categorySong:
                return 1
            }
        }
        return 0
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 60))
        let labelTitle = UILabel(frame: CGRect(x: 10, y: 10, width: tableView.frame.width - 20, height: 40))
        labelTitle.text = viewModel.titleForHeaderInSection(inSection: section)
        labelTitle.textColor = UIColor.black
        labelTitle.font = UIFont(name: "HelveticaNeue-Bold", size: 17)
        headerView.addSubview(labelTitle)
        return headerView
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if (section != 0) && (section != 2) {
            let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 60))
            let doneButton = UIButton(frame: CGRect(x: tableView.frame.width - 100, y: 0, width: 400, height: 40))
            let titleLabel = UILabel(frame: CGRect(x: tableView.frame.width - 100, y: 0, width: 300, height: 40))
            titleLabel.text = "Xem thêm"
            titleLabel.font = UIFont(name: "HelveticaNeue", size: 16)
            titleLabel.textColor = UIColor.red
            doneButton.backgroundColor = UIColor.clear
            doneButton.tag = section
            doneButton.addTarget(self, action: #selector(viewMorePlaylistsSong), for: .touchUpInside)
            footerView.addSubview(doneButton)
            footerView.addSubview(titleLabel)
            return footerView
        } else {
            return nil
        }
    }

    @objc func viewMorePlaylistsSong(sender: UIButton) {
        let tag = sender.tag
        switch tag {
        case 1:
            let listTopSong = ListTopSongViewController()
            navigationController?.pushViewController(listTopSong, animated: true)
        case 3:
            let listTopSong = ListCategorySongViewController()
            navigationController?.pushViewController(listTopSong, animated: true)
        default: print("44444444")
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let section = HomeViewModel.Section(rawValue: indexPath.section) {
            switch section {
            case .loveDaySong:
                guard let cell = homeTableView.dequeueReusableCell(withIdentifier: App.String.songEveryDayTableViewCell, for: indexPath) as? SongEveryDayTableViewCell else { fatalError() }
                cell.viewModel = viewModel.cellForItemSectionEveryDaySong(at: indexPath)
                cell.backgroundColor = UIColor.clear
                cell.selectionStyle = .none
                return cell
            case .topSong:
                guard let cell = homeTableView.dequeueReusableCell(withIdentifier: App.String.topSongTableViewCell, for: indexPath) as? TopSongTableViewCell else { fatalError() }
                cell.viewModel = viewModel.cellForItemSectionNewReleases(at: indexPath)
                cell.backgroundColor = UIColor.clear
                cell.selectionStyle = .none
                return cell
            case .youCanLike:
                guard let cell = homeTableView.dequeueReusableCell(withIdentifier: App.String.likeSong, for: indexPath) as? LikeSongTableCell else { fatalError() }
                cell.viewModel = viewModel.cellForRowAtTrendingLikeSong(at: indexPath)
                cell.selectionStyle = .none
                cell.backgroundColor = UIColor.clear
                return cell
            case .categorySong:
                guard let cell = homeTableView.dequeueReusableCell(withIdentifier: App.String.categoryCell, for: indexPath) as? CategorySongTableCell else { fatalError() }
                cell.backgroundColor = UIColor.clear
                return cell
            }
        }
        return UITableViewCell()
    }
}
