//
//  EScooterService.swift
//  EScooters
//
//  Created by Sasi Moorthy on 23/05/19.
//  Copyright © 2019 Sasi Moorthy. All rights reserved.
//

import Foundation

let apiEndPoint = "https://my-json-server.typicode.com/FlashScooters/Challenge/db"

enum Result {
    case success(Any)
    case failure(String)
}

class ApiService {
    /*
     * Create URLRequest and downloads data from given url
     */
    func fetchData(url: String, completion: @escaping (_ responseData: Data?, _ error: Error?) -> Void) {
        var request = URLRequest(url: URL(string: url)!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 30.0)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) -> Void in
            completion(data, error)
        }
        task.resume()
    }
}

class EScooterService {
    
    let apiService: ApiService
    
    init(_ apiService: ApiService = ApiService()) {
        self.apiService = apiService
    }
    
    func fetchVehiclesList(completion: @escaping (_ result: Result) -> () ) {
        apiService.fetchData(url: apiEndPoint) { (data, error) in
            DispatchQueue.main.async(execute: {
                if error != nil {
                    completion(Result.failure("Unable to download vehicle list \(error?.localizedDescription ??  "No data received")"))
                } else {
                    if let data = data {
                        let response = String(data: data, encoding: String.Encoding.utf8)
                        print(response as Any)
                    } else {
                        completion(Result.failure("No data received"))
                    }
                }
            })
        }
    }
}


