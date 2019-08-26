//
//  API.swift
//  PhotoRequest
//
//  Created by skrr on 20.08.19.
//  Copyright © 2019 mic. All rights reserved.
//

import Foundation
import UIKit

enum API {
  
  case photoList
  case photoItem(String)
  
  enum Result<Value> {
    case success(Value)
    case failure(String)
  }
  
  func makeRequest(completion: @escaping (Result<Data>)->()) {
    
    var endpointUrl: URL? {
      switch self {
      case .photoList:
        return URL(string: "https://jsonplaceholder.typicode.com/photos")
        
      case .photoItem(let imgId):
        return URL(string: "https://via.placeholder.com/600/\(imgId)")
      }
    }
    
    if let url = endpointUrl {
      URLSession.shared.dataTask(with: url) { data, response, error in
        if let data = data {
          completion(Result.success(data))
        }
        
        if let error = error {
          completion(Result.failure(error.localizedDescription))
        }
        }.resume()
    }
  }
  
  func decodeJson(data: Data, completion: @escaping (Result<Any>)->()) {
    let decoder = JSONDecoder()
    do {
      switch self {
      case .photoList:
        let photos = try decoder.decode([PhotoItem].self, from: data)
        print("decoded")
        completion(.success(photos))
        
      case .photoItem(_):
        print("expected imagedata")
      }
      
    } catch {
      print(error.localizedDescription)
    }
  }
}
