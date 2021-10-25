//
//  NewTeamViewController.swift
//  MindTeamsChallenge
//
//  Created by Francisco Escobar on 20/10/21.
//

import UIKit

class NewTeamViewController: UIViewController {

    let newTeamViewModel = NewTeamViewModel()
    
    @IBOutlet weak var nameField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func save(_ sender: Any) {
        
        newTeamViewModel.team.name = nameField.text!
        newTeamViewModel.save {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
