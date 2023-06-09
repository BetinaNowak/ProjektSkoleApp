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

// Post users
class NetworkServiceUsersPost {
    
    static func getPostString(params:[String? : Any?]) -> String
    {
        var data = [String]()
        //for i in stride(from: 0, to: params.count, by: 1){
            for(key, value) in params
            {
                data.append(key! + "=\(value!)")
            }
        //}
        
        return data.map { String($0) }.joined(separator: "&")
    }
    
    static func callPost(url:URL, params:[String? : Any?])
    {
        var request = URLRequest(url: url)
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
                let defaults = UserDefaults.standard
                defaults.set(params["brugernavn"]!, forKey: "brugernavn")
                print(defaults.string(forKey: "brugernavn")!)
                // save to user locals
                // let defaults = UserDefaults.standard

            }

            print(result)
        }
        task.resume()
        
    }
}

// Get applications
class NetworkServiceSingleUser {
  static var sharedObj = NetworkServiceSingleUser()
  let singleUserSession = URLSession.init(configuration: .default)
  
    func getSingleUser(brugernavn: String?, onSucces: @escaping(Users) -> Void) {
      let singleUserUrlPath = URL(string: "http://test-postnord.dk/api-get-bruger.php?brugernavn="+String(brugernavn!))
      let task = singleUserSession.dataTask(with: singleUserUrlPath!) {
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
