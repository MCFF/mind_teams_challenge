//
//  NewTeamMemberViewController.swift
//  MindTeamsChallenge
//
//  Created by Francisco Escobar on 22/10/21.
//

import UIKit

class NewTeamMemberViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var userList: UITableView!
    @IBOutlet weak var startDate: UIDatePicker!
    @IBOutlet weak var endDate: UIDatePicker!
    @IBOutlet weak var saveButton: UIButton!
    
    
    let newTeamMemberViewModel = NewTeamMemberViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        newTeamMemberViewModel.bindViewController = {
            self.userList.reloadData()
        }
        newTeamMemberViewModel.getUsers()
    }
    
    @IBAction func save(_ sender: Any) {
        
      
        newTeamMemberViewModel.saveWith(startDate: startDate.date, endDate: endDate.date, completionHandler: {
            self.dismiss(animated: true, completion: nil)
        })
    }
    
    
    //MARK: - TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newTeamMemberViewModel.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "user"){
            
            let name = cell.viewWithTag(1) as! UILabel
            name.text = newTeamMemberViewModel.users[indexPath.row].name
            
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        newTeamMemberViewModel.userSelected = newTeamMemberViewModel.users[indexPath.row]
    }
}
