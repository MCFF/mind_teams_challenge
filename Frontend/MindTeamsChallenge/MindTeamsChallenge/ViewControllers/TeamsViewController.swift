//
//  TeamsViewController.swift
//  MindTeamsChallenge
//
//  Created by Francisco Escobar on 20/10/21.
//

import UIKit

class TeamsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    private let teamsViewModel = TeamsViewModel()
    
    @IBOutlet weak var teamsList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bindViewModel()
        teamsViewModel.getTeams()
    }
    
    func bindViewModel(){
        
        teamsViewModel.bindViewController = {
            self.teamsList.reloadData()
        }
    }
    
    //MARK: -tableview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teamsViewModel.teams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "team"){
            
            let name = cell.viewWithTag(1) as! UILabel
            name.text = teamsViewModel.teams[indexPath.row].name
            
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        teamsList.deselectRow(at: indexPath, animated: true)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let teamMembersVC = storyboard.instantiateViewController(withIdentifier: "teamMembersVC") as! TeamMembersViewController
        
        teamMembersVC.teamMembersViewModel.team = teamsViewModel.teams[indexPath.row]
        
        self.present(teamMembersVC, animated: true, completion: nil)
    }
    
    //MARK: - segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.destination is NewTeamViewController{
            let newTeamViewController = segue.destination as! NewTeamViewController
            
            newTeamViewController.newTeamViewModel.saveCompletionHandler = { newTeam in
                self.teamsViewModel.teams.append(newTeam)
            }
        }
    }
}
