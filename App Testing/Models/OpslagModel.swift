//
//  OpslagModel.swift
//  App Testing
//
//  Created by Betina Svendsen on 23/03/2023.
//

import Foundation

struct Opslag: Codable {
    var id: Int?
    var titel: String?
    var opslag_type: String?
    var kategori: String?
    var varighed: String?
    var adresse_1: String?
    var adresse_2: String?
    var by: String?
    var post_nr: String?
    var beskrivelse: String?
    var adgangskrav: String?
    var optagelse: String?
    var jobmuligheder: String?
    var cover_billede: String?
    var telefon: String?
    var email: String?
    var virksomhedsnavn: String?
    
    
    
    
}

typealias Posts = [Opslag]
