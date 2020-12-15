//
//  LoginViewController.swift
//  MyApp
//
//  Created by Tran Dinh Nhan on 6/13/18.
//  Copyright © 2018 Nhan Tran. All rights reserved.
//

import UIKit
import SafariServices
import AVFoundation
import SVProgressHUD

class LoginViewController: UIViewController {

    // Variables
    var auth = SPTAuth.defaultInstance()
    var session: SPTSession!
    var player: SPTAudioStreamingController?
    var loginUrl: URL?
    @IBOutlet weak var imageLoginView: UIImageView!
    @IBOutlet weak var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        navigationController?.isNavigationBarHidden = true
        NotificationCenter.default.addObserver(self, selector: #selector(loginAccountSpotify), name: NSNotification.Name(rawValue: "loginSuccessfull"), object: nil)
        configUIView()
    }

    func configUIView() {
        loginButton.layer.cornerRadius = 5
        loginButton.clipsToBounds = true
        loginButton.border(color: UIColor.black, width: 0.5)
    }

    @objc func loginAccountSpotify() {
        let userDefaults = UserDefaults.standard
        if let sessionObj: AnyObject = userDefaults.object(forKey: "SpotifySession") as AnyObject? {
            let sessionDataObj1 = sessionObj as? Data
            guard let sessionDataObj = sessionDataObj1 else { return }
            let firstTimeSession = NSKeyedUnarchiver.unarchiveObject(with: sessionDataObj) as? SPTSession
            self.session = firstTimeSession
            self.loginButton.isHidden = true
            api.session.accessToken = session.accessToken
            AppDelegate.shared.changeRootWithState(state: .openApp)
        }
    }

    func setup() {
        let redirectURL = "MyApp://returnAfterLogin"
        let clientID = "944050cdb42d414980439b5f3389ac2e"
        guard let auth = auth else { return }
        auth.redirectURL = URL(string: redirectURL)
        auth.clientID = clientID
        auth.requestedScopes = [SPTAuthStreamingScope, SPTAuthPlaylistReadPrivateScope, SPTAuthPlaylistModifyPublicScope, SPTAuthPlaylistModifyPrivateScope]
        loginUrl = auth.spotifyWebAuthenticationURL()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loginButton(_ sender: Any) {
        guard let auth = auth else { return }
        guard let loginUrl = loginUrl else { return }
        if UIApplication.shared.openURL(loginUrl) {
            if auth.canHandle(auth.redirectURL) {
                print("-------------1------------")
                self.loginButton.isHidden = true
            }
        }
    }
}
