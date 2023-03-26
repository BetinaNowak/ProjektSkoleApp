//
//  Posts.swift
//  App Testing
//
//  Created by Betina Svendsen on 23/03/2023.
//

import Foundation

class NetworkServicePosts {
  static var sharedObj = NetworkServicePosts()
  let postSession = URLSession.init(configuration: .default)
  let postsUrlPath = URL(string: "http://test-postnord.dk/api-get-opslag.php")!
  
    func getPosts(onSucces: @escaping(Posts) -> Void) {
    let task = postSession.dataTask(with: postsUrlPath) {
      (data, response, error) in
      DispatchQueue.main.async {
        if let data = data {
          do {
            let decodedata = try JSONDecoder().decode(Posts.self, from: data)
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