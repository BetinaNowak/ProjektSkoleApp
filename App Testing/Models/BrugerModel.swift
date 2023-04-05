//
//  BrugerModel.swift
//  App Testing
//
//  Created by Betina Svendsen on 05/04/2023.
//

import Foundation

struct Bruger: Codable {
    var id: Int?
    var fornavn: String?
    var efternavn: String?
    var email: String?
    var billede: String?
    var foedselsdato: Date?
    var brugernavn: String?
    var adgangskode: String?
    var skole: String?
    var klassetrin: String?
    var adresse_1: String?
    var adresse_2: String?
    var by: String?
    var post_nr: String?
}

typealias Users = [Bruger]
