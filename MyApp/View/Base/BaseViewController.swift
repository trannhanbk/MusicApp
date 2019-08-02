//
//  BaseViewController.swift
//  MyApp
//
//  Created by Tran Dinh Nhan on 6/27/18.
//  Copyright © 2018 Nhan Tran. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    @IBOutlet weak var uivew: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func setupUI() {
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.isTranslucent = false
    }

    func addCurrentView() -> UIView {
        let screenBound = UIScreen.main.bounds

        let currentView = UIView(frame: CGRect(x: 0,
                                        y: screenBound.maxY - 40,
                                        width: screenBound.width,
                                        height: 40))

        currentView.backgroundColor = .red
        return currentView
    }
}
