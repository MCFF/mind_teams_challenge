//
//  NewUserViewController.swift
//  MindTeamsChallenge
//
//  Created by Francisco Escobar on 20/10/21.
//

import UIKit

class NewUserViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    let newUserViewModel = NewUserViewModel()
    private let roles = ["Super user", "Admin", "User"]
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var englishLevelField: UIFieldStepper!
    @IBOutlet weak var skillsField: UITextField!
    @IBOutlet weak var cvField: UITextField!
    @IBOutlet weak var rolePicker: UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func save(_ sender: Any) {
        
        if let name = nameField.text, let password = passwordField.text, let email = emailField.text,  let skills = skillsField.text, let cv = cvField.text{
            newUserViewModel.user.name = name
            newUserViewModel.user.email = email
            newUserViewModel.user.englishLevel = englishLevelField.value
            newUserViewModel.user.skills = skills
            newUserViewModel.user.cv = cv
            newUserViewModel.user.roleId = rolePicker.selectedRow(inComponent: 0)+1
            newUserViewModel.saveWith(password: password){
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func cancel(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: -pickerview
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return roles[row]
    }
    

}
