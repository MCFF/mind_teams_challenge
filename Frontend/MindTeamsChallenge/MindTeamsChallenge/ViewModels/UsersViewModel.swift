//
//  UsersViewModel.swift
//  MindTeamsChallenge
//
//  Created by Francisco Escobar on 20/10/21.
//

import Foundation

class UsersViewModel{
    
    private let api = Api()
    
    var users = [User](){
        didSet{
            bindViewController()
        }
    }
    
    var bindViewController = {}
    
    func getUsers(){
        api.getDataFrom(url: "users", params: [:]){data in
            
            do{
                self.users = try JSONDecoder().decode([User].self, from: data)
                self.bindViewController()
            }catch{
                print("error \(error)")
            }
        }
    }
}
