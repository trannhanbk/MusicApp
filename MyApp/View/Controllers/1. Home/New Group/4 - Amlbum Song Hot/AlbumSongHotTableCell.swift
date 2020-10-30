//
//  AlbumSongHotTableCell.swift
//  MyApp
//
//  Created by Tran Dinh Nhan on 6/5/18.
//  Copyright © 2018 Nhan Tran. All rights reserved.
//

import UIKit

class AlbumSongHotTableCell: UITableViewCell {

    @IBOutlet private weak var albumCollectionView: UICollectionView!
    var viewModel = AlbumSongTableCellVM()
    fileprivate var isLoading = false

    override func awakeFromNib() {
        super.awakeFromNib()
        albumCollectionView.delegate = self
        albumCollectionView.dataSource = self
        let nib = UINib(nibName: App.String.albumHotItem, bundle: nil)
        albumCollectionView.register(nib, forCellWithReuseIdentifier: App.String.albumHotItem)
        albumCollectionView.backgroundColor = UIColor.clear
//        refresh()
    }

//    func refresh() {
//        if isLoading { return }
//        isLoading = true
//        viewModel.refresh { [weak self] (result) in
//            guard let this = self else { return }
//            switch result {
//            case .success:
//                this.albumCollectionView.reloadData()
//                this.isLoading = false
//            case .failure: break
//            }
//        }
//    }
}

extension AlbumSongHotTableCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = albumCollectionView.dequeueReusableCell(withReuseIdentifier: App.String.albumHotItem, for: indexPath) as? AlbumHotItem else { fatalError() }
        cell.backgroundColor = UIColor.clear
        cell.viewModel = viewModel.cellForRowAtTrendingSongList(at: indexPath)
        return cell
    }
}

extension AlbumSongHotTableCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 150)
    }
}
