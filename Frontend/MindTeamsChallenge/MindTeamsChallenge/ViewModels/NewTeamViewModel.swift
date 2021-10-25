//
//  NewTeamViewModel.swift
//  MindTeamsChallenge
//
//  Created by Francisco Escobar on 20/10/21.
//

import Foundation

class NewTeamViewModel{
    
    private let api = Api()
    var team = Team()
    
    var bindViewController = {}
    var saveCompletionHandler: (Team)->() = {newTeam in}
    
    func save(completionHandler: @escaping ()->()){
        
        do{
            var teamData = try JSONEncoder().encode(team)
            if var jsonData = try JSONSerialization.jsonObject(with: teamData, options: []) as? [String: Any]{
                
                jsonData.removeValue(forKey: "id")
                
                teamData = try JSONSerialization.data(withJSONObject: jsonData, options: [])
                
                api.postDataFrom(url: "teams", params: teamData){data in

                    DispatchQueue.main.async {
                        
                        
                        do{
                            let newTeam = try JSONDecoder().decode(Team.self, from: data)
                            self.saveCompletionHandler(newTeam)
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
