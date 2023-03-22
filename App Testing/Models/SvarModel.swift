//
//  SvarModel.swift
//  App Testing
//
//  Created by Betina Svendsen on 22/03/2023.
//

import Foundation

struct Svar: Codable {
    var id: Int?
    var spoergsmaal_id: Int?
    var svar_tekst: String?
}
typealias Answers = [Svar]
