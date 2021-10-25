//
//  Account.swift
//  MindTeamsChallenge
//
//  Created by Francisco Escobar on 19/10/21.
//

import Foundation

struct Account: Codable{
    var id = 0
    var name = ""
    var clientName = ""
    var devOpsName = ""
    var teamId = 0
    var team = Team()
}
