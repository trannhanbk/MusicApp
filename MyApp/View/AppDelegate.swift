//
//  AppDelegate.swift
//  MyApp
//
//  Created by Quang Dang N.K on 5/9/18.
//  Copyright © 2018 Nhan Tran. All rights reserved.
//

import UIKit
import LGSideMenuController

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var auth = SPTAuth()
    
    static let shared: AppDelegate = {
        guard let shared = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Cannot cast `UIApplication.shared.delegate` to `AppDelegate`.")
        }
        return shared
    }()
    
    enum AppState {
        case login
        case openApp
    }

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configWindow()
        return true
    }
    
    func configWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        window?.makeKeyAndVisible()
        auth.redirectURL = URL(string: "MyApp://returnAfterLogin") // insert your redirect URL here
        auth.sessionUserDefaultsKey = "current session"
        if api.session.isAuthenticated {
            changeRootWithState(state: .openApp)
        } else {
            changeRootWithState(state: .login)
        }
    }

    func changeRootWithState(state: AppState) {
        switch state {
        case .login:
            let loginVC = LoginViewController()
            window?.rootViewController = loginVC
        case .openApp:
            let homeVC = HomeViewController()
            let naviVC = UINavigationController(rootViewController: homeVC)
            let sideMenu = LGSideMenuController(rootViewController: naviVC)
            sideMenu.leftViewController = MenuViewController()
            sideMenu.leftViewWidth = 3 * UIScreen.main.bounds.width / 4
            sideMenu.leftViewPresentationStyle = .slideBelow
            window?.rootViewController = sideMenu
        }
    }

    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        if auth.canHandle(auth.redirectURL) {
            auth.handleAuthCallback(withTriggeredAuthURL: url, callback: { (error, session) in
                if error != nil {
                    print("error!")
                }
                guard let accessToken = session?.accessToken else { return }
                api.session.accessToken = accessToken
                let userDefaults = UserDefaults.standard
                let sessionData = NSKeyedArchiver.archivedData(withRootObject: session ?? "")
                print(sessionData)
                userDefaults.set(sessionData, forKey: "SpotifySession")
                userDefaults.synchronize()
                NotificationCenter.default.post(name: Notification.Name(rawValue: "loginSuccessfull"), object: nil)
            })
            return true
        }
        return false
    }
}
