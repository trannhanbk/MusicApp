//
//  CategorySongTableCell.swift
//  MyApp
//
//  Created by Tran Dinh Nhan on 6/5/18.
//  Copyright © 2018 Nhan Tran. All rights reserved.
//

import UIKit

class CategorySongTableCell: UITableViewCell {
    @IBOutlet private weak var categorySongCollectionView: UICollectionView!
    var viewModel = CategorySongTableCellVM()
    fileprivate var isLoading = false
    override func awakeFromNib() {
        super.awakeFromNib()
        categorySongCollectionView.delegate = self
        categorySongCollectionView.dataSource = self
        let nib = UINib(nibName: "CollectionViewCell", bundle: nil)
        categorySongCollectionView.register(nib, forCellWithReuseIdentifier: "CollectionViewCell")
        categorySongCollectionView.backgroundColor = UIColor.clear
        refresh()
    }

    func refresh() {
        if isLoading { return }
        isLoading = true
        viewModel.refresh { [weak self] (result) in
            guard let this = self else { return }
            switch result {
            case .success:
                this.categorySongCollectionView.reloadData()
                this.isLoading = false
            case .failure: break
            }
        }
    }
}

extension CategorySongTableCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSectionCategorySong()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = categorySongCollectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? CollectionViewCell else { fatalError() }
        cell.backgroundColor = UIColor.white
        cell.viewModel = viewModel.cellForRowAtCategorySongList(at: indexPath)
        return cell
    }
}

extension CategorySongTableCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let uri = viewModel.cellForRowAtCategorySongList(at: indexPath).item.uri
        let name = viewModel.cellForRowAtCategorySongList(at: indexPath).item.name ?? ""
        let href = viewModel.cellForRowAtCategorySongList(at: indexPath).item.tracks?.href ?? ""
        let image = viewModel.cellForRowAtCategorySongList(at: indexPath).item.image?.first?.url ?? ""
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SelecPlaySong"), object: nil, userInfo: ["Items": ItemPlayer(uri: uri, image: image, name: name, href: href)])
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 100)
    }
}
