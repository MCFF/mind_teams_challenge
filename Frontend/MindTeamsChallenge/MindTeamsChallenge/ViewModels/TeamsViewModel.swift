//
//  TeamsViewModel.swift
//  MindTeamsChallenge
//
//  Created by Francisco Escobar on 20/10/21.
//

import Foundation

class TeamsViewModel{
    
    private let api = Api()
    var teams = [Team](){
        didSet{
            bindViewController()
        }
    }
    var bindViewController = {}
    
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
}
