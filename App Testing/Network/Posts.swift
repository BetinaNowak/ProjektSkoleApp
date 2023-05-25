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
  let postsUrlPath = URL(string: "http://test-postnord.dk/api-get-opslag.php?user_id=1")!
  
    func getPosts(onSucces: @escaping(Posts) -> Void) {
    let task = postSession.dataTask(with: postsUrlPath) {
      (data, response, error) in
      DispatchQueue.main.async {
        if let data = data {
          do {
            let decodedata = try JSONDecoder().decode(Posts.self, from: data)
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


// Get praktik opslag
class NetworkServicePostsInternship {
  static var sharedObj = NetworkServicePostsInternship()
  let postInternshipSession = URLSession.init(configuration: .default)
  let postsInternshipUrlPath = URL(string: "http://test-postnord.dk/api-get-opslag.php?user-id=1&opslag-type=praktik")!
  
    func getInternshipPosts(onSucces: @escaping(Posts) -> Void) {
    let task = postInternshipSession.dataTask(with: postsInternshipUrlPath) {
      (data, response, error) in
      DispatchQueue.main.async {
        if let data = data {
          do {
            let decodedata = try JSONDecoder().decode(Posts.self, from: data)
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


// Get uddannelse opslag
class NetworkServicePostsEducation {
  static var sharedObj = NetworkServicePostsEducation()
  let postEducationSession = URLSession.init(configuration: .default)
  let postsEducationUrlPath = URL(string: "http://test-postnord.dk/api-get-opslag.php?user-id=1&opslag-type=uddannelse")!
  
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

// Get uddannelse opslag
class NetworkServiceSavedPosts {
  static var sharedObj = NetworkServiceSavedPosts()
  let savedPostSession = URLSession.init(configuration: .default)
  let savedPostUrlPath = URL(string: "http://test-postnord.dk/api-get-opslag.php?user_id=1&saved=true")!
  
    func getSavedPosts(onSucces: @escaping(Posts) -> Void) {
    let task = savedPostSession.dataTask(with: savedPostUrlPath) {
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

// Post save/unsave opslag
class NetworkServiceToggleSavePost {
  
    static func getPostString(params:[[String? : String?]]) -> String
    {
        var data = [String]()
        for i in stride(from: 0, to: params.count, by: 1){
            for(key, value) in params[i]
            {
                data.append(key! + "=\(value!)")
            }
        }
        
        return data.map { String($0) }.joined(separator: "&")
    }
    
    static func toggleSavePosts(params:[[String? : String?]]) {
        //var sharedObj = NetworkServiceToggleSavePost()
        //let toggleSavePostSession = URLSession.init(configuration: .default)
        let toggleSavePostUrlPath = URL(string: "http://test-postnord.dk/api-post-save-opslag.php")!
        
        var request = URLRequest(url: URL(string: "http://test-postnord.dk/api-post-save-opslag.php")!)
        request.httpMethod = "POST"

        let postString = self.getPostString(params: params)
        print(postString)
        request.httpBody = postString.data(using: .utf8)

        var result:(message:String, data:Data?) = (message: "Fail", data: nil)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in

            if(error != nil)
            {
                result.message = "Fail Error not null : \(error.debugDescription)"
            }
            else
            {
                result.message = "Success"
                result.data = data
            }

            print(result)
        }
        task.resume()
  }
    
}
