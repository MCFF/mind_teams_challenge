//
//  AccountDetailsViewController.swift
//  MindTeamsChallenge
//
//  Created by Francisco Escobar on 22/10/21.
//

import UIKit

class AccountDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let accountDetailsViewModel = AccountDetailsViewModel()
    
    @IBOutlet weak var accountNameLabel: UILabel!
    @IBOutlet weak var teamList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
        accountDetailsViewModel.bindViewController = {
            self.updateUI()
        }
        accountDetailsViewModel.getMembers()
    }
    
    func updateUI(){
        
        accountNameLabel.text = accountDetailsViewModel.account.name
        teamList.reloadData()
        
    }
    
    
    //MARK: -tableview
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let members = accountDetailsViewModel.account.team.members{
            
            return members.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "member"), let members = accountDetailsViewModel.account.team.members {
            
            let name = cell.viewWithTag(1) as! UILabel
            name.text = members[indexPath.row].name
            
            return cell
        }
        return UITableViewCell()
    }
    
    //MARK: -Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.destination is NewTeamMemberViewController{
            let newTeamMemeberVC = segue.destination as! NewTeamMemberViewController
            
            newTeamMemeberVC.newTeamMemberViewModel.team = self.accountDetailsViewModel.account.team
            newTeamMemeberVC.newTeamMemberViewModel.saveCompletionHandler = { user in
                
                self.accountDetailsViewModel.account.team.members?.append(user)
            }
        }
    }

}
