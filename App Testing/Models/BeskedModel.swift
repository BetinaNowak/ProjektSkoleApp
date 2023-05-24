//
//  BeskedModel.swift
//  App Testing
//
//  Created by mediastyle on 23/05/2023.
//

import Foundation

struct Besked: Codable {
    var id: Int?
    var chat_id: Int?
    var bruger_fra: Int?
    var bruger_til: String?
    var besked: String?
    var dato: String?
}

typealias Message = [Besked]
