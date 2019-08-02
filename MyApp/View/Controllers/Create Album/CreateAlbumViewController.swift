//
//  CreateAlbumViewController.swift
//  MyApp
//
//  Created by Tran Dinh Nhan on 6/22/18.
//  Copyright © 2018 Nhan Tran. All rights reserved.
//

import UIKit
import RealmSwift

class CreateAlbumViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var tableViewMyAlbum: UITableView!
    var alertController: UIAlertController?
    var viewModel = MyAlbumViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configTableCell()
    }

    private func configTableCell() {
        let nib = UINib(nibName: App.String.myAlbumCell, bundle: Bundle.main)
        tableViewMyAlbum.register(nib, forCellReuseIdentifier: App.String.myAlbumCell)
        tableViewMyAlbum.delegate = self
        tableViewMyAlbum.dataSource = self
        tableViewMyAlbum.backgroundColor = UIColor.clear
    }

    @IBAction func closeScreenButton(_ sender: Any) {
        let home = HomeViewController()
        sideMenuController?.rootViewController = UINavigationController(rootViewController: home)
    }

    @IBAction func createAlbumButton(_ sender: Any) {
        createAlbum()
    }

    func createAlbum() {
        alertController = UIAlertController(title: "★★★★★ HELLO ★★★★★", message: "Do you want create new album?", preferredStyle: .alert)
        alertController?.addTextField(configurationHandler: { (textField) in
            textField.placeholder = "Name album"
        })
        alertController?.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            switch action.style {
            case .default:
                guard let textField = self.alertController?.textFields?[0] else { return }
                do {
                    let realm = try Realm()
                    try realm.write {
                        let itemMyAlbum = MyAlbum()
                        let text = textField.text ?? ""
                        for item in realm.objects(MyAlbum.self) {
                            if item.name != text {
                                itemMyAlbum.name = text
                            } else {
                                realm.delete(item)
                                print("Delete -----------")
                            }
                        }
                        realm.add(itemMyAlbum)
                    }
                } catch {
                    print("-------------------Not delete---------------------")
                }
//                self.createAlbum()
                self.tableViewMyAlbum.reloadData()
            case .cancel: break
            case .destructive: break
            }
        }))
        alertController?.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        guard let alertController = alertController else { return }
        self.present(alertController, animated: true, completion: nil)
    }
}

extension CreateAlbumViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableViewMyAlbum.dequeueReusableCell(withIdentifier: App.String.myAlbumCell, for: indexPath) as? MyAlbumTableViewCell else { fatalError() }
        do {
            let realm = try Realm()
            cell.updateCell(data: realm.objects(MyAlbum.self)[indexPath.row + 1])
        } catch {
            print("Error Realm-----------")
        }
        cell.accessoryType = .disclosureIndicator
        cell.backgroundColor = UIColor.clear
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        viewModel.editingStyle(tableViewMyAlbum, commit: editingStyle, forRowAt: indexPath)
    }
}

extension CreateAlbumViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let navi = ListMyAlbumViewController()
        navi.viewModel = viewModel.viewModelForListPlaySong(at: indexPath)
        present(navi, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
