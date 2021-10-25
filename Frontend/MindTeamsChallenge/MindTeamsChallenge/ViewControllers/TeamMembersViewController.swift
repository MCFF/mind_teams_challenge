//
//  TeamMembersViewController.swift
//  MindTeamsChallenge
//
//  Created by Francisco Escobar on 22/10/21.
//

import UIKit

class TeamMembersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var teamMembersViewModel = TeamMembersViewModel()
    
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var userList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.teamNameLabel.text = self.teamMembersViewModel.team.name
        teamMembersViewModel.bindViewController = {
            
            self.userList.reloadData()
        }
        teamMembersViewModel.getMembers()
    }
    
    //MARK: -TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let members = teamMembersViewModel.team.members{
            return members.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "user"), let members = teamMembersViewModel.team.members {
            
            let name = cell.viewWithTag(1) as! UILabel
            name.text = members[indexPath.row].name
            
            return cell
        }
        return UITableViewCell()
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.destination is NewTeamMemberViewController{
            let newTeamMemberViewController = segue.destination as! NewTeamMemberViewController
            
            newTeamMemberViewController.newTeamMemberViewModel.team = teamMembersViewModel.team
            newTeamMemberViewController.newTeamMemberViewModel.saveCompletionHandler = { user in
                if let _ = self.teamMembersViewModel.team.members{
                    self.teamMembersViewModel.team.members!.append(user)
                }
            }
        }
    }
}
