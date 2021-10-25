//
//  TeamMembersViewModel.swift
//  MindTeamsChallenge
//
//  Created by Francisco Escobar on 22/10/21.
//

import Foundation

class TeamMembersViewModel{
    
    let api = Api()
    var team = Team(){
        didSet{
            
            bindViewController()
        }
    }
    
    var bindViewController = {}
    
    func getMembers(){
        
        self.team.members = [User]()
        api.getDataFrom(url: "teams/\(team.id)/members", params: [:], completionHandler: { data in
            
            do{
                let dataJson = try JSONSerialization.jsonObject(with: data, options: []) as! [[String: Any]]
                
                
                for user in dataJson{
                    
                    let userData = user["user"] as! [String: Any]
                    
                    if let id = userData["id"] as? Int, let name = userData["name"] as? String, let email = userData["email"] as? String, let englishLevel = userData["englishLevel"] as? Int, let skills = userData["skills"] as? String, let cv = userData["cv"] as? String, let roleId = userData["roleId"] as? Int{
                        
                        let user = User(id: id, name: name, email: email, englishLevel: englishLevel, skills: skills, cv: cv, roleId: roleId, role: Role())
                        
                        self.team.members?.append(user)
                        
                    }
                }
                
            }catch{
                print("error \(error)")
            }
        })
    }
}
