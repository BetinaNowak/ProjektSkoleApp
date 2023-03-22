//
//  Network Questions.swift
//  App Testing
//
//  Created by Betina Svendsen on 22/03/2023.
//

import Foundation


// Get questions and answers
class NetworkServiceQuestions {
  static var sharedObj = NetworkServiceQuestions()
  let questionSession = URLSession.init(configuration: .default)
  let questionsUrlPath = URL(string: "http://test-postnord.dk.linux21.curanetserver.dk/api-get-spoergsmaal.php")!
  func getQuestions(onSucces: @escaping(Questions) -> Void) {
    let task = questionSession.dataTask(with: questionsUrlPath) {
      (data, response, error) in
      DispatchQueue.main.async {
        if let data = data {
          do {
            let decodedata = try JSONDecoder().decode(Questions.self, from: data)
            //print(decodedata.count)
            //print(decodedata[0].spoergsmaal_tekst ?? "text")
            //print(String(data: data, encoding: .utf8 )!)
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
