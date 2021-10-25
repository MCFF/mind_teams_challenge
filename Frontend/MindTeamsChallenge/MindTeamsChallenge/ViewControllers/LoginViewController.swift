//
//  LoginViewController.swift
//  MindTeamsChallenge
//
//  Created by Francisco Escobar on 19/10/21.
//

import UIKit

class LoginViewController: UIViewController {

    private let loginViewModel = LoginViewModel()
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loginViewModel.bindViewController = {
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let projectsVC = storyboard.instantiateViewController(withIdentifier: "projectsVC")
            
            projectsVC.modalPresentationStyle = .fullScreen
            
            self.present(projectsVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func login(_ sender: Any) {
        
        if let email = emailField.text, let password = passwordField.text{
        
            loginViewModel.loginWith(email: email, password: password)
        }
    }
    

}
