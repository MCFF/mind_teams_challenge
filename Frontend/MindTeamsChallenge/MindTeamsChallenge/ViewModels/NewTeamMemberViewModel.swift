//
//  NewTeamMemberViewModel.swift
//  MindTeamsChallenge
//
//  Created by Francisco Escobar on 22/10/21.
//

import Foundation

class NewTeamMemberViewModel{
    
    var api = Api()
    
    var userSelected = User()
    var team = Team()
    var users = [User](){
        didSet{
            
            bindViewController()
        }
    }
    var bindViewController = {}
    var saveCompletionHandler: (User)->() = {newUser in}
    
    func getUsers(){
        
        api.getDataFrom(url: "users", params: [:]){data in
            
            do{
                self.users = try JSONDecoder().decode([User].self, from: data)
                
            }catch{
                print("error \(error)")
            }
        }
    }
    
    func saveWith(startDate: Date, endDate: Date, completionHandler: @escaping ()->()){
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY/MM/dd h:m:s"
        let start = dateFormatter.string(from: startDate)
        let end = dateFormatter.string(from: endDate)
        
        let params = ["userId": userSelected.id,"startDate": start, "endDate": end] as [String:Any]
        
        do{
            
            let paramsData = try JSONSerialization.data(withJSONObject: params, options: [])
        
            api.postDataFrom(url: "teams/\(team.id)/members", params: paramsData, completionHandler: { data in
                
                do{
                    
                    let user = try JSONDecoder().decode(User.self, from: data)
                    
                    self.saveCompletionHandler(user)
                    completionHandler()
                    
                }catch{
                    print("error \(error)")
                }
            })
            }catch{
                print("error \(error)")
            }
    }
}
