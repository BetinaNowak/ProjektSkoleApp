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
  
    func getMessages(id: Int?, onSucces: @escaping(Message) -> Void) {
      let messageUrlPath = URL(string: "http://test-postnord.dk/api-get-beskeder.php?chat_id="+String(id!))
      let task = messageSession.dataTask(with: messageUrlPath!) {
      (data, response, error) in
      DispatchQueue.main.async {
        if let data = data {
          do {
            let decodedata = try JSONDecoder().decode(Message.self, from: data)
            print(decodedata.count)
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

// Post besked
class NetworkServicePostMessage {
  
    static func getPostString(params:[String? : Any?]) -> String
    {
        var data = [String]()
       // for i in stride(from: 0, to: params.count, by: 1){
            for(key, value) in params
            {
                data.append(key! + "=\(value!)")
            }
       // }
        
        return data.map { String($0) }.joined(separator: "&")
    }
    
    static func sendBesked(params:[String? : Any?]) {
        
        var request = URLRequest(url: URL(string: "http://test-postnord.dk/api-post-besked.php")!)
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
