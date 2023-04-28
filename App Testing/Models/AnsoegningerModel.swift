//
//  AnsoegningerModel.swift
//  App Testing
//
//  Created by Betina Svendsen on 27/04/2023.
//

import Foundation

struct Ansoegning: Codable {
    var id: Int?
    var ansoeger_id: Int?
    var ansoeger_navn: String?
    var ansoeger_email: String?
    var ansoeger_skole: String?
    var ansoeger_klassetrin: String?
    var ansoeger_beskrivelse: String?
    var praktik_id: Int?
    var praktik_titel: String?
    var praktik_email: String?
    var praktik_virksomhedsnavn: String?
    var praktik_start_dato: String?
    var ansoegning_accepteret: Int?
}

typealias Application = [Ansoegning]
