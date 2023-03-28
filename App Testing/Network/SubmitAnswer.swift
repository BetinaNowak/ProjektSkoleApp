//
//  PostAnswer.swift
//  App Testing
//
//  Created by mediastyle on 23/03/2023.
//

import Foundation

class ApiService
{
    static func getPostString(params:[[String? : Int?]]) -> String
    {
        var data = [String]()
        for i in stride(from: 0, to: params.count, by: 1){
            for(key, value) in params[i]
            {
                data.append(key! + String(i+1) + "=\(value!)")
            }
        }
        
        return data.map { String($0) }.joined(separator: "&")
    }

    static func callPost(url:URL, params:[[String? : Int?]])
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
            }

            print(result)
        }
        task.resume()
    }
}

