//
//  Posts.swift
//  App Testing
//
//  Created by Betina Svendsen on 23/03/2023.
//

import Foundation

// Get all opslag
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


// Get praktik opslag
class NetworkServicePostsInternship {
  static var sharedObj = NetworkServicePostsInternship()
  let postInternshipSession = URLSession.init(configuration: .default)
  let postsInternshipUrlPath = URL(string: "http://test-postnord.dk/api-get-opslag.php?opslag-type=praktik")!
  
    func getInternshipPosts(onSucces: @escaping(Posts) -> Void) {
    let task = postInternshipSession.dataTask(with: postsInternshipUrlPath) {
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


// Get uddannelse opslag
class NetworkServicePostsEducation {
  static var sharedObj = NetworkServicePostsEducation()
  let postEducationSession = URLSession.init(configuration: .default)
  let postsEducationUrlPath = URL(string: "http://test-postnord.dk/api-get-opslag.php?opslag-type=uddannelse")!
  
    func getEducationPosts(onSucces: @escaping(Posts) -> Void) {
    let task = postEducationSession.dataTask(with: postsEducationUrlPath) {
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
