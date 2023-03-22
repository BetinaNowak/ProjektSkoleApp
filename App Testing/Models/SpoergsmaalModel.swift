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
    var svar_1: String?
    var svar_2: String?
    var svar_3: String?
    var svar_4: String?
    var svar_5: String?
    var svar_6: String?
}
typealias Questions = [Spoergsmaal]
