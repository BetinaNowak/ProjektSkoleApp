//
//  Network.swift
//  App Testing
//
//  Created by Betina Svendsen on 17/03/2023.
//

import Foundation
class NetworkService {
  static var sharedObj = NetworkService()
  let session = URLSession.init(configuration: .default)
  let urlPath = URL(string: "http://test-postnord.dk.linux21.curanetserver.dk/service.php")!
  func getInfo(onSucces: @escaping(Info) -> Void) {
    //let task = URLSession.shared.dataTask(with: urlPath) { (data, response, error) in
    let task = session.dataTask(with: urlPath) {
      (data, response, error) in
      DispatchQueue.main.async {
        if let data = data {
          do {
            let decodedata = try JSONDecoder().decode(Info.self, from: data)
            //print(decodedata.count)
            //print(decodedata[0].name ?? "name")
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


// Get questions and answers
/*class NetworkServiceQuestions {
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
}*/



// Get answers
/*
class NetworkServiceAnswers {
  static var sharedObj = NetworkServiceAnswers()
  let answerSession = URLSession.init(configuration: .default)
  let answersUrlPath = URL(string: "http://test-postnord.dk.linux21.curanetserver.dk/api-get-svar.php?id=1")!
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
}*/


/*
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
}*/
