//
//  Answers2.swift
//  App Testing
//
//  Created by Betina Svendsen on 22/03/2023.
//

import Foundation

// Get answers for the second question
class NetworkServiceAnswers2 {
  static var sharedObj = NetworkServiceAnswers2()
  let answerSession = URLSession.init(configuration: .default)
  let answersUrlPath = URL(string: "http://test-postnord.dk.linux21.curanetserver.dk/api-get-svar.php?id=2")!
  func getAnswers(onSucces: @escaping(Answers) -> Void) {
    let task = answerSession.dataTask(with: answersUrlPath) {
      (data, response, error) in
      DispatchQueue.main.async {
        if let data = data {
          do {
            let decodedata = try JSONDecoder().decode(Answers.self, from: data)
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
