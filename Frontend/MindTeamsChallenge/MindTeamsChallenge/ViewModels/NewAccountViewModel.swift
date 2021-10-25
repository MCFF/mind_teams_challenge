//
//  NewAccountViewModel.swift
//  MindTeamsChallenge
//
//  Created by Francisco Escobar on 20/10/21.
//

import Foundation

class NewAccountViewModel{
    
    private var api = Api()
    var teams = [Team](){
        didSet{
            bindTeams()
        }
    }
    var account = Account()
    var bindViewController = {}
    var bindTeams = {}
    var saveCompletionHandler: (Account)->() = {newAccount in}
    
    func getTeams(){
        
        api.getDataFrom(url: "teams", params: [:], completionHandler: { data in
            
            do{
                self.teams = try JSONDecoder().decode([Team].self, from: data)
                self.bindViewController()
            }catch{
                print("error \(error)")
            }
        })
    }
    
    func save(completionHandler: @escaping ()->()){
        
        do{
            var accountData = try JSONEncoder().encode(account)
            var jsonAccount = try JSONSerialization.jsonObject(with: accountData, options: []) as! [String: Any]
            jsonAccount.removeValue(forKey: "id")
            
            accountData = try JSONSerialization.data(withJSONObject: jsonAccount, options: [])
            
            api.postDataFrom(url: "accounts", params: accountData, completionHandler: { data in
                
                DispatchQueue.main.async {
                    
                    do{
                        let newAccount = try JSONDecoder().decode(Account.self, from: data)
                        self.saveCompletionHandler(newAccount)
                    }catch{
                        print("error \(error)")
                    }
                    completionHandler()
                }
                
            })
        }catch{
            print("error \(error)")
        }
    }
}
