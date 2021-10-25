//
//  User.swift
//  MindTeamsChallenge
//
//  Created by Francisco Escobar on 19/10/21.
//

import Foundation

struct User: Codable{
    var id = 0
    var name = ""
    var email = ""
    var englishLevel = 0
    var skills = ""
    var cv = ""
    var roleId = 0
    var role = Role()
}
