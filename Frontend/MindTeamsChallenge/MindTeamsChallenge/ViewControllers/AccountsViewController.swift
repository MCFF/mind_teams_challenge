//
//  AccountsViewController.swift
//  MindTeamsChallenge
//
//  Created by Francisco Escobar on 19/10/21.
//

import UIKit

class AccountsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var accountsViewModel = AccountsViewModel()
    
    @IBOutlet weak var accountsList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bindAccountViewModel()
        accountsViewModel.getAccounts()
    }
    
    func bindAccountViewModel(){
        
        accountsViewModel.bindViewController = {
            self.accountsList.reloadData()
        }
    }

    //MARK: - tableview
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        accountsViewModel.accounts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = accountsList.dequeueReusableCell(withIdentifier: "account"){
            
            let accountName = cell.viewWithTag(1) as! UILabel
            accountName.text = accountsViewModel.accounts[indexPath.row].name
            
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let accountDetailVC = storyboard.instantiateViewController(withIdentifier: "accountDetailVC") as! AccountDetailsViewController
        
        accountDetailVC.accountDetailsViewModel.account = accountsViewModel.accounts[indexPath.row]
        
        self.present(accountDetailVC, animated: true, completion: nil)
    }
    
    //MARK: -Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.destination is NewAccountViewController{
            let newAccountViewController = segue.destination as! NewAccountViewController
            
            newAccountViewController.newAccountViewModel.saveCompletionHandler = { newAccount in
                self.accountsViewModel.accounts.append(newAccount)
            }
        }
    }
}
