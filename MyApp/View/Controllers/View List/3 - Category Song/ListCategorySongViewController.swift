//
//  ListCategorySongViewController.swift
//  MyApp
//
//  Created by Tran Dinh Nhan on 6/6/18.
//  Copyright © 2018 Nhan Tran. All rights reserved.
//

import UIKit
import SVProgressHUD

class ListCategorySongViewController: UIViewController {

    @IBOutlet weak var imageBackground: UIImageView!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    var viewModel = ListCategorySongViewModel()
    fileprivate var isLoading = false
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "CHỦ ĐỀ VÀ THỂ LOẠI"
        navigationController?.isNavigationBarHidden = false
        configCollectionView()
        refresh()
        configNavigationBar()
    }

    private func configCollectionView() {
        let nib = UINib(nibName: App.String.listCategorySong, bundle: Bundle.main)
        categoryCollectionView.register(nib, forCellWithReuseIdentifier: App.String.listCategorySong)
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        categoryCollectionView.backgroundColor = UIColor.clear
    }

    func configNavigationBar() {
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "icons8-back-filled-51").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(backToHomeButton))
         navigationItem.leftBarButtonItem = backButton
        navigationController?.navigationBar.barTintColor = UIColor.white
    }

    @objc func backToHomeButton() {
        navigationController?.popViewController(animated: true)
    }

    func refresh() {
        if isLoading { return }
        isLoading = true
        SVProgressHUD.show()
        viewModel.refresh { [weak self] (result) in
            guard let this = self else { return }
            switch result {
            case .success:
                this.categoryCollectionView.reloadData()
                this.isLoading = false
            case .failure: break
            }
            SVProgressHUD.dismiss()
        }
    }
}

extension ListCategorySongViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: App.String.listCategorySong, for: indexPath) as? ListCategorySongCollectionCell else { fatalError() }
        cell.viewModel = viewModel.cellForRowAtTrendingSongList(at: indexPath)
        cell.backgroundColor = UIColor.clear
        return cell
    }
}

extension ListCategorySongViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let navi = ListCategoryItemViewController()
        navi.viewModel = viewModel.viewModelForListCategory(at: indexPath)
        navigationController?.pushViewController(navi, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2 - 5, height: 100)
    }
}
