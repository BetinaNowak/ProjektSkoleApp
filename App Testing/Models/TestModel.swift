//
//  TestModel.swift
//  App Testing
//
//  Created by Betina Svendsen on 17/03/2023.
//

import Foundation

struct TestInfo: Codable {
    var name: String?
    var age: Int?
    var username: String?
    var password: String?
}

typealias Info = [TestInfo]
