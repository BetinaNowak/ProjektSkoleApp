//
//  QuestionModel.swift
//  App Testing
//
//  Created by mediastyle on 20/03/2023.
//

import Foundation

struct Spoergsmaal: Codable {
    var id: Int?
    var type: String?
    var max_antal_svar: Int?
    var spoergsmaal_tekst: String?
}
typealias Questions = [Spoergsmaal]
