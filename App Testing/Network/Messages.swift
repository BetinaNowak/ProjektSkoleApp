//
//  Messages.swift
//  App Testing
//
//  Created by mediastyle on 23/05/2023.
//

import Foundation


// Get applications
class NetworkServiceMessages {
  static var sharedObj = NetworkServiceMessages()
  let messageSession = URLSession.init(configuration: .default)
  let messageUrlPath = URL(string: "http://test-postnord.dk/api-get-beskeder.php")!
  func getMessages(onSucces: @escaping(Message) -> Void) {
    let task = messageSession.dataTask(with: messageUrlPath) {
      (data, response, error) in
      DispatchQueue.main.async {
        if let data = data {
          do {
            let decodedata = try JSONDecoder().decode(Message.self, from: data)
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
