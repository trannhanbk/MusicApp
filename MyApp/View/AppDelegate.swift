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

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        gotoLogin()
        window?.makeKeyAndVisible()
        auth.redirectURL = URL(string: "MyApp://returnAfterLogin") // insert your redirect URL here
        auth.sessionUserDefaultsKey = "current session"
        return true
    }

    func gotoLogin() {
        let navi = LoginViewController()
        let navigationController = UINavigationController(rootViewController: navi)
        let sideMenuController = LGSideMenuController(rootViewController: navigationController)
        sideMenuController.leftViewController = MenuViewController()
        sideMenuController.leftViewWidth = 3 * UIScreen.main.bounds.width / 4
        sideMenuController.leftViewPresentationStyle = .slideBelow
        window?.rootViewController = sideMenuController
    }

    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        if auth.canHandle(auth.redirectURL) {
            auth.handleAuthCallback(withTriggeredAuthURL: url, callback: { (error, session) in
                if error != nil {
                    print("error!")
                }
                UserDefaults.standard.set(session?.accessToken, forKey: "kAccessToken")
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
