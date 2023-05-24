//
//  Applications.swift
//  App Testing
//
//  Created by Betina Svendsen on 27/04/2023.
//

import Foundation

// Get applications
class NetworkServiceApplications {
  static var sharedObj = NetworkServiceApplications()
  let applicationSession = URLSession.init(configuration: .default)
  let applicationsUrlPath = URL(string: "http://test-postnord.dk/api-get-ansoegning.php")!
  func getApplications(onSucces: @escaping(Application) -> Void) {
    let task = applicationSession.dataTask(with: applicationsUrlPath) {
      (data, response, error) in
      DispatchQueue.main.async {
        if let data = data {
          do {
            let decodedata = try JSONDecoder().decode(Application.self, from: data)
            //print(decodedata.count)
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
