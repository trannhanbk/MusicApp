//
//  MyAlbumTableViewCell.swift
//  MyApp
//
//  Created by Tran Dinh Nhan on 6/27/18.
//  Copyright © 2018 Nhan Tran. All rights reserved.
//

import UIKit

class MyAlbumCell: UITableViewCell {

    @IBOutlet weak var imageAlbum: UIImageView!
    @IBOutlet weak var nameAlbum: UILabel!
    @IBOutlet weak var numberOfSong: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func updateCell(data: MyAlbum) {
        nameAlbum.text = data.name
    }
}
