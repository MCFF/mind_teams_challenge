//
//  UsersViewController.swift
//  MindTeamsChallenge
//
//  Created by Francisco Escobar on 20/10/21.
//

import UIKit

class UsersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var usersViewModel = UsersViewModel()
    
    @IBOutlet weak var userList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bindViewModel()
        usersViewModel.getUsers()
    }
    
    func bindViewModel(){
        usersViewModel.bindViewController = {
            self.userList.reloadData()
        }
    }
    
    //MARK: -tableview

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        usersViewModel.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "user"){
            
            let name = cell.viewWithTag(1) as! UILabel
            name.text = usersViewModel.users[indexPath.row].name
            
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        userList.deselectRow(at: indexPath, animated: true)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let userProfileVC = storyboard.instantiateViewController(withIdentifier: "userProfileVC") as! UserProfileViewController
        
        userProfileVC.userProfileViewModel.user = usersViewModel.users[indexPath.row]
        userProfileVC.userProfileViewModel.saveCompletionHandler = { updatedUser in
            
            self.usersViewModel.users = self.usersViewModel.users.map({ $0.id == updatedUser.id ? updatedUser : $0 })
        }
        
        self.present(userProfileVC, animated: true, completion: nil)
    }
    
    //MARK: -Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.destination is NewUserViewController{
            let newUserViewController = segue.destination as! NewUserViewController
            
            newUserViewController.newUserViewModel.saveCompletionHandler = { newUser in
                self.usersViewModel.users.append(newUser)
            }
        }
    }
}
