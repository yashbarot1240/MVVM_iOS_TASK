//
//  HTTPManager.swift
//  Yash_Task
//
//  Created by DevstreeAir2 on 24/03/21.
//

import UIKit


let baseUrl : String = "https://imaginato.mocklab.io"
let loginURL : String = "/login"



class HTTPManager {
    static let shared: HTTPManager = HTTPManager()

    enum HTTPError: Error {
        case invalidURL
        case invalidResponse(Data?, URLResponse?)
    }
    
    public func post(urlString: String,params : [String : Any], completionBlock: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completionBlock(.failure(HTTPError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "Post"
        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                completionBlock(.failure(error!))
                return
            }

            guard
                let responseData = data,
                let httpResponse = response as? HTTPURLResponse,
                200 ..< 300 ~= httpResponse.statusCode else {
                    completionBlock(.failure(HTTPError.invalidResponse(data, response)))
                    return
            }

            completionBlock(.success(responseData))
        }
        
        task.resume()
    }
}

