//
//  AccountsViewModel.swift
//  MindTeamsChallenge
//
//  Created by Francisco Escobar on 19/10/21.
//

import Foundation

class AccountsViewModel{
    
    private let api = Api()
    
    var accounts = [Account](){
        didSet{
            bindViewController()
        }
    }
    
    var bindViewController = {}
    
    
    func getAccounts(){
        
        api.getDataFrom(url: "accounts", params: [:]){data in
            
            do{
                self.accounts = try JSONDecoder().decode([Account].self, from: data)
            }catch{
                print("error \(error)")
            }
        }
    }
}
