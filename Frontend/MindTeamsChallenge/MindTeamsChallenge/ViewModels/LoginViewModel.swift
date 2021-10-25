//
//  LoginViewModel.swift
//  MindTeamsChallenge
//
//  Created by Francisco Escobar on 19/10/21.
//

import Foundation

class LoginViewModel{
    private let api = Api()
    private let userDefaults = UserDefaults.standard
    
    var user = User(){
        didSet{
            bindViewController()
        }
    }
    var bindViewController = {}
    
    
    func loginWith(email: String, password: String){
        api.loginWith(email: email, password: password){token in
            self.userDefaults.set(token, forKey: "token")
            self.bindViewController()
        }
    }
}
