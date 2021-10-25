//
//  UserProfileViewModel.swift
//  MindTeamsChallenge
//
//  Created by Francisco Escobar on 21/10/21.
//

import Foundation

class UserProfileViewModel{
    
    var saveCompletionHandler: (User)->() = {newUser in}
    
    private var api = Api()
    var user = User(){
        didSet{
            bindViewController()
        }
    }
    var roles = [Role](){
        didSet{
            bindRoles()
        }
    }
    var bindViewController = {}
    var bindRoles = {}
    
    func getRoles(){
        
        api.getDataFrom(url: "roles", params: [:], completionHandler: { data in
            
            DispatchQueue.main.async {
                
                do{
                    self.roles = try JSONDecoder().decode([Role].self, from: data)
                }catch{
                    print("error roles \(error)")
                }
            }
        })
    }
    
    func update(){
        
        do{
            
            var params = try JSONEncoder().encode(user)
            var paramsJson = try JSONSerialization.jsonObject(with: params, options: []) as! [String:Any]
            
            paramsJson.removeValue(forKey: "id")
            paramsJson.removeValue(forKey: "role")
            
            params = try JSONSerialization.data(withJSONObject: paramsJson, options: [])
            
            
            api.putData(url: "users/\(user.id)", params: params, completionHandler: { data in
             
                DispatchQueue.main.async {
                    do{
                        
                        self.user = try JSONDecoder().decode(User.self, from: data)
                        self.saveCompletionHandler(self.user)
                    }catch{
                        print("error \(error)")
                    }
                }
                
            })
        }catch{
            print("error \(error)")
        }
    }
}
