//
//  Session.swift
//  MyApp
//
//  Created by Tran Dinh Nhan on 6/13/18.
//  Copyright © 2018 Nhan Tran. All rights reserved.
//

import UIKit

let kAccessToken = "AccessToken"
let kUserID = "UserID"
let kIsVerified = "kIsVerified"
let kEmail = "Email"

final class Session {
    
    struct Credential {
        var username: String
        var password: String
        
        var isValid: Bool {
            return username.isNotEmpty && password.isNotEmpty
        }
    }
    
    var credential = Credential(username: "", password: "")
    
    var accessToken: String? {
        didSet {
            guard accessToken != nil else {
                clearAccessToken()
                return
            }
            saveAccessToken()
        }
    }
    
    var userID: Int {
        get {
            return UserDefaults.standard.integer(forKey: kUserID)
        }
        
        set {
            UserDefaults.standard.setValue(newValue, forKey: kUserID)
        }
    }
    
    var email: String? {
        get {
            return UserDefaults.standard.string(forKey: kEmail)
        }
        
        set {
            UserDefaults.standard.setValue(newValue, forKey: kEmail)
        }
    }
    
    var isVerified: Bool {
        get {
            return UserDefaults.standard.bool(forKey: kIsVerified)
        }
        
        set {
            UserDefaults.standard.setValue(newValue, forKey: kIsVerified)
        }
    }
    
    var isAuthenticated: Bool {
        return accessToken != nil
    }
    
    func saveAccessToken() {
        let userDefault = UserDefaults.standard
        userDefault.setValue(accessToken, forKey: kAccessToken)
        userDefault.synchronize()
    }
    
    func clearAccessToken() {
        let userDefault = UserDefaults.standard
        userDefault.removeObject(forKey: kAccessToken)
        userDefault.synchronize()
    }
    
    func loadAccessToken() {
        let userDefaults = UserDefaults.standard
        accessToken = userDefaults.string(forKey: kAccessToken)
    }
    
    func clearCredential() {
        credential.username = ""
        credential.password = ""
    }
    
    func reset() {
        accessToken = nil
        userID = 0
        isVerified = false
        email = nil
        clearCredential()
    }
}
