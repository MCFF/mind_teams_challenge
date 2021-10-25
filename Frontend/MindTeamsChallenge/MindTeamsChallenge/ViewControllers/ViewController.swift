//
//  ViewController.swift
//  MindTeamsChallenge
//
//  Created by Francisco Escobar on 16/10/21.
//

import UIKit

class ViewController: UIViewController {

    private let userDefaults = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    override func viewDidAppear(_ animated: Bool) {
        if userDefaults.string(forKey: "token") != nil{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mainTabBarVC = storyboard.instantiateViewController(withIdentifier: "mainTabBarVC")
            
            mainTabBarVC.modalPresentationStyle = .fullScreen
            
            self.present(mainTabBarVC, animated: true, completion: nil)
        }else{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let loginVC = storyboard.instantiateViewController(withIdentifier: "loginVC")
            
            self.present(loginVC, animated: true, completion: nil)
            
        }
    }

}

