//
//  VirksomhedModel.swift
//  App Testing
//
//  Created by mediastyle on 06/06/2023.
//

import Foundation

struct Virksomhed: Codable {
    var id: Int?
    var navn: String?
    var kort_beskrivelse: String?
    var lang_beskrivelse: String?
    var billede: String?
    var adresse: String?
    var type: String?
}

typealias Company = [Virksomhed]
