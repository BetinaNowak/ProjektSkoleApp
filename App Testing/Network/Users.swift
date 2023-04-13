//
//  Users.swift
//  App Testing
//
//  Created by Betina Svendsen on 05/04/2023.
//

import Foundation


// Get users
class NetworkServiceUsers {
  static var sharedObj = NetworkServiceUsers()
  let userSession = URLSession.init(configuration: .default)
  let usersUrlPath = URL(string: "http://test-postnord.dk/api-get-bruger.php")!
  func getUsers(onSucces: @escaping(Users) -> Void) {
    let task = userSession.dataTask(with: usersUrlPath) {
      (data, response, error) in
      DispatchQueue.main.async {
        if let data = data {
          do {
            let decodedata = try JSONDecoder().decode(Users.self, from: data)
            print(decodedata.count)
            print(String(data: data, encoding: .utf8 )!)
            onSucces(decodedata)
          } catch {
            print(error.localizedDescription)
          }
        }
      }
    }
    task.resume()
  }
}
