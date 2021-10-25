//
//  NewAccountViewController.swift
//  MindTeamsChallenge
//
//  Created by Francisco Escobar on 20/10/21.
//

import UIKit

class NewAccountViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var newAccountViewModel = NewAccountViewModel()
    
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var clientNameField: UITextField!
    @IBOutlet weak var devOpsNameField: UITextField!
    @IBOutlet weak var teamPicker: UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bindTeams()
        newAccountViewModel.getTeams()
    }
    
    func bindTeams(){
        newAccountViewModel.bindTeams = {
            self.teamPicker.reloadComponent(0)
        }
    }
    
    @IBAction func save(_ sender: Any) {
        
        if let name = nameField.text, let clientName = clientNameField.text, let devOpsName = devOpsNameField.text{
            
            let teamRowSelected = teamPicker.selectedRow(inComponent: 0)
            
            newAccountViewModel.account.name = name
            newAccountViewModel.account.clientName = clientName
            newAccountViewModel.account.devOpsName = devOpsName
            newAccountViewModel.account.teamId = newAccountViewModel.teams[teamRowSelected].id
            
            newAccountViewModel.save {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func cancel(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: - picker

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return newAccountViewModel.teams.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return newAccountViewModel.teams[row].name
    }
}
