//
//  TabbarViewController.swift
//  MyApp
//
//  Created by NHAN TRAN D. on 17/12/2020.
//  Copyright © 2020 Nhan Tran. All rights reserved.
//

import UIKit
import SwifterSwift
import LGSideMenuController

final class TabbarViewController: UITabBarController {

    static weak var share: TabbarViewController?
    private var home = UINavigationController()
    private var tv = UINavigationController()
    private var videos = UINavigationController()
    private var setting = UINavigationController()
    private var beforeItem: ItemType = .home
    private var controllersCount = 4
    var isLandscape = false

    let hiddenOrigin: CGPoint = {
        let y = kScreenSize.height + Measurement.tabBarHeight + 70
        let x: CGFloat = 0
        let coordinate = CGPoint(x: x, y: y)
        return coordinate
    }()

    let minimizedOrigin: CGPoint = {
        let x: CGFloat = 0
        let y: CGFloat = kScreenSize.height - Measurement.tabBarHeight - 60
        let coordinate = CGPoint(x: x, y: y)
        return coordinate
    }()

    let fullScreenOrigin: CGPoint = CGPoint(x: 0.0, y: 0.0)

    enum ItemType: Int {
        case home = 0
        case tv

        var title: String {
            switch self {
            case .home: return "Home"
            case .tv: return "Favorite"
            }
        }

        var image: UIImage? {
            switch self {
            case .home: return #imageLiteral(resourceName: "img_tabbar_home")
            case .tv: return #imageLiteral(resourceName: "img_tabbar_favorite")
            }
        }

        var selectedImage: UIImage? {
            switch self {
            case .home: return #imageLiteral(resourceName: "img_tabbar_home")
            case .tv: return #imageLiteral(resourceName: "ic_favorite_red_48dp")
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        TabbarViewController.share = self
        configDefaultViewControllers()
        configureUI()
        delegate = self
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    func configDefaultViewControllers() {
        home = UINavigationController(rootViewController: HomeViewController())
        tv = UINavigationController(rootViewController: FavoriteViewController())
        let sideMenu = LGSideMenuController(rootViewController: home)
        sideMenu.leftViewController = MenuViewController()
        sideMenu.leftViewWidth = 3 * UIScreen.main.bounds.width / 4
        sideMenu.leftViewPresentationStyle = .slideBelow

        let viewControllers: [UIViewController] = [
            sideMenu,
            tv
        ]
        controllersCount = viewControllers.count
        setViewControllers(viewControllers, animated: true)
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.black]
        viewControllers.enumerated().forEach { index, viewController in
            let tabBarType = ItemType(rawValue: index)
            let tabBarItem = UITabBarItem(
                title: tabBarType?.title,
                image: tabBarType?.image,
                selectedImage: tabBarType?.selectedImage
            )
            tabBarItem.tag = index
            tabBarItem.setTitleTextAttributes(attributes, for: .normal)
            viewController.tabBarItem = tabBarItem
            tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 0)
        }
    }

    var topPresentController: UIViewController? {
        var topController: UIViewController = self
        while let presentedViewController = topController.presentedViewController {
            topController = presentedViewController
        }
        return topController
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if UIDevice.current.orientation.isLandscape {
            isLandscape = true

        } else {
            isLandscape = false
        }
    }

    func animateToTab(to tab: ItemType) {
        animateToTab(to: tab.rawValue)
    }

    func animateToTab(to toIndex: Int) {
        guard let selectedViewController = selectedViewController, let fromView = selectedViewController.view, let fromIndex = viewControllers?.firstIndex(of: selectedViewController) else { return }
        beforeItem = ItemType(rawValue: fromIndex) ?? .home
        guard let toView = viewControllers?[toIndex].view, fromIndex != toIndex else { return }

        // Add the toView to the tab bar view
        fromView.superview?.addSubview(toView)

        // Position toView off screen (to the left/right of fromView)
        let screenWidth = SwifterSwift.screenWidth
        let scrollRight = toIndex > fromIndex
        let offset = (scrollRight ? screenWidth : -screenWidth)
        toView.center = CGPoint(x: fromView.center.x + offset, y: toView.center.y)

        // Disable interaction during animation
        view.isUserInteractionEnabled = false
        let animations = {
            fromView.center.x -= offset
            toView.center.x -= offset
        }
        let completion = { (_: Bool) -> Void in
            fromView.removeFromSuperview()
            self.selectedIndex = toIndex
            self.view.isUserInteractionEnabled = true
        }
        UIView.animate(
            withDuration: 0.2,
            delay: 0,
            options: .curveEaseOut,
            animations: animations,
            completion: completion
        )
    }

    func backToPreviousVC() {
        animateToTab(to: beforeItem)
    }
}

// MARK: - Private functions
extension TabbarViewController {
    private func configureUI() {
        tabBar.setColors(
            background: .black,
            selectedBackground: .clear,
            item: #colorLiteral(red: 0.4588235294, green: 0.4588235294, blue: 0.4588235294, alpha: 1),
            selectedItem: .white
        )

        tabBar.isTranslucent = true
        tabBar.barTintColor = .clear
        tabBar.backgroundColor = .black
        tabBar.layer.backgroundColor = UIColor.clear.cgColor
        tabBar.tintColor = .white

        let blurEffect = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = tabBar.bounds
        blurView.height += 34
        blurView.autoresizingMask = .flexibleWidth
        tabBar.insertSubview(blurView, at: 0)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        if let style = selectedViewController?.preferredStatusBarStyle {
            return style
        }
        return .lightContent
    }
}

// MARK: - Extension UITabBarControllerDelegate
extension TabbarViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        guard let tabViewControllers = tabBarController.viewControllers, let toIndex = tabViewControllers.firstIndex(of: viewController) else {
            return false
        }
        animateToTab(to: toIndex)
        return true
    }
}
