//
//  Session.swift
//  MyApp
//
//  Created by Tran Dinh Nhan on 6/13/18.
//  Copyright © 2018 Nhan Tran. All rights reserved.
//

import Foundation

final class Session {

    // MARK: - Properties
    var accessToken: String? {
        didSet {
            guard accessToken != nil else {
                clearAccessToken()
                return
            }
            saveAccessToken()
        }
    }

    // MARK: - Public funcs
    // AccessToken
    func saveAccessToken() {
        let userDefaults = UserDefaults.standard
        userDefaults.set(accessToken, forKey: UserDefaults.Key.accessToken)
        userDefaults.synchronize()
    }

    func loadAccessToken() {
        let userDefaults = UserDefaults.standard
        accessToken = userDefaults.string(forKey: UserDefaults.Key.accessToken)
    }

    func clearAccessToken() {
        let userDefaults = UserDefaults.standard
        userDefaults.removeObject(forKey: UserDefaults.Key.accessToken)
    }

    init() { }

    struct Credential: CustomStringConvertible {
        let email: String
        let pass: String

        var isValid: Bool {
            return !email.isEmpty && !pass.isEmpty
        }

        var description: String {
            guard isValid, let base64 = "\(email):\(pass)".base64(.encode) else { return "" }
            return "Basic \(base64)"
        }
    }

    var credential = Credential(email: "", pass: "") {
        didSet {
            saveCredential()
        }
    }

    func loadCredential() {
        let host = Api.Path.baseURL.host
        guard let accounts = SAMKeychain.accounts(forService: host)?.last,
            let account = accounts[kSAMKeychainAccountKey] as? String else { return }

        guard let password = SAMKeychain.password(forService: host, account: account) else { return }
        credential = Credential(email: account, pass: password)
    }

    private func saveCredential() {
        guard credential.isValid else { return }
        let host = Api.Path.baseURL.host
        SAMKeychain.setPassword(credential.pass, forService: host, account: credential.email)
    }

    func clearCredential() {
        credential = Credential(email: "'", pass: "")
        let host = Api.Path.baseURL.host
        guard let accounts = SAMKeychain.accounts(forService: host) else { return }
        for account in accounts {
            if let account = account[kSAMKeychainAccountKey] as? String {
                SAMKeychain.deletePassword(forService: host, account: account)
            }
        }
    }

    func reset() {
        clearCredential()
        accessToken = nil
    }
}
