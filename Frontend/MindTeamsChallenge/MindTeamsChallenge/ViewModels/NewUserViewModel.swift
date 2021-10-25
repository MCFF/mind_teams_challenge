//
//  NewUserViewModel.swift
//  MindTeamsChallenge
//
//  Created by Francisco Escobar on 20/10/21.
//

import Foundation

class NewUserViewModel{
    
    private let api = Api()
    var user = User()
    
    var bindViewController = {}
    var saveCompletionHandler: (User)->() = {newUser in}
    
    func saveWith(password: String, completionHandler: @escaping ()->()){
        
        do{
            var userData = try JSONEncoder().encode(user)
            if var jsonData = try JSONSerialization.jsonObject(with: userData, options: []) as? [String: Any]{
                jsonData["password"] = password
                jsonData.removeValue(forKey: "id")
                jsonData.removeValue(forKey: "role")
                
                userData = try JSONSerialization.data(withJSONObject: jsonData, options: [])
                
                api.postDataFrom(url: "users", params: userData){data in

                    DispatchQueue.main.async {
                        
                        
                        do{
                            let newUser = try JSONDecoder().decode(User.self, from: data)
                            self.saveCompletionHandler(newUser)
                        }catch{
                            print("fallo new user \(error)")
                        }
                        
                        completionHandler()
                    }
                    
                }
            }
            
        }catch{
            print("error \(error)")
        }
    }
}
