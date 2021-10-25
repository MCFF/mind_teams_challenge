//
//  UserProfileViewController.swift
//  MindTeamsChallenge
//
//  Created by Francisco Escobar on 21/10/21.
//

import UIKit

class UserProfileViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, UIFieldStepperDelegate {
    
    var userProfileViewModel = UserProfileViewModel()
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var englishLevelField: UIFieldStepper!
    @IBOutlet weak var skillsField: UITextField!
    @IBOutlet weak var cvField: UITextField!
    @IBOutlet weak var rolePicker: UIPickerView!
    @IBOutlet weak var editButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        englishLevelField.fieldStepperDelegate = self
        userProfileViewModel.getRoles()
        disableInputs()
        setData()
        
        userProfileViewModel.bindViewController = {
            self.setData()
        }
        userProfileViewModel.bindRoles = {
            self.rolePicker.reloadComponent(0)
            self.rolePicker.selectRow(self.userProfileViewModel.user.role.id-1, inComponent: 0, animated: true)
        }
    }
    
    func disableInputs(){
        nameField.makeDisabled()
        emailField.makeDisabled()
        englishLevelField.isEditable = false
        skillsField.makeDisabled()
        cvField.makeDisabled()
        rolePicker.isUserInteractionEnabled = false
        
    }
    
    func setData(){
        
        nameField.text = userProfileViewModel.user.name
        emailField.text = userProfileViewModel.user.email
        englishLevelField.defaultValue = userProfileViewModel.user.englishLevel
        skillsField.text = userProfileViewModel.user.skills
        cvField.text = userProfileViewModel.user.cv
        
    }

    @IBAction func edit(_ sender: Any) {
        
        if !self.isEditing{
            nameField.makeEnabled()
            emailField.makeEnabled()
            englishLevelField.isEditable = true
            skillsField.makeEnabled()
            cvField.makeEnabled()
            editButton.setTitle("Save", for: .normal)
            rolePicker.isUserInteractionEnabled = true
        }else{
            nameField.makeDisabled()
            emailField.makeDisabled()
            englishLevelField.isEditable = false
            skillsField.makeDisabled()
            cvField.makeDisabled()
            editButton.setTitle("Edit", for: .normal)
            rolePicker.isUserInteractionEnabled = false
            save()
        }
        
        self.isEditing = !self.isEditing
    }
    
    func save() {
  
        disableInputs()
        editButton.setTitle("Edit", for: .normal)
        userProfileViewModel.update()
        
    }
    
    //MARK: -textfield
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
      
            
        if var updatedText = textField.text{
            if string.isEmpty{
                let lastIndex = updatedText.index(before: updatedText.endIndex)
                updatedText.remove(at: lastIndex)
            }else{
                updatedText.append(string)
            }
            
            switch textField{
            case nameField:
                userProfileViewModel.user.name = updatedText
            case emailField:
                
                userProfileViewModel.user.email = updatedText
                
            case skillsField:
                
                userProfileViewModel.user.skills = updatedText
                
            case cvField:
                
                userProfileViewModel.user.cv = updatedText
                
                
            default:
                break
            }
        }
        
        return false
    }
    
    func valueDidChange(_ fieldStepper: UIFieldStepper) {
        userProfileViewModel.user.englishLevel = englishLevelField.value
    }
    
    //MARK: -picker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return userProfileViewModel.roles.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return userProfileViewModel.roles[row].role
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        userProfileViewModel.user.roleId = pickerView.selectedRow(inComponent: 0)+1
    }
}

extension UITextField{
    
    func makeDisabled(){
        self.backgroundColor = .white
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 1
        self.isEnabled = false
        self.textColor = UIColor(named: "LightBlack")
    }
    
    func makeEnabled(){
        self.layer.borderWidth = 0
        self.isEnabled = true
    }
    
}
