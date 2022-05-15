//
//  APIManager.swift
//  TestProject
//
//  Created by Arsen Mkrtchyan on 14.05.22.
//

import Foundation



typealias JSONTask = URLSessionDataTask
typealias JSONCompletionHandler = ([String: AnyObject]?, HTTPURLResponse?, Error?) -> Void

enum APIResult<T> {
  case success([T])
  case failure(Error)
}

protocol FinalURLPoint {
  var baseURL: URL { get }
  var searchURL: String {get}
  var path: String { get }
  static var request: URLRequest { get }
  var searchRequest: URLRequest { get }
}
protocol JSONDecodable {
    init?(JSON: [String: AnyObject])
}

protocol APIManager {
  var sessionConfiguration: URLSessionConfiguration { get }
  var session: URLSession { get }
  
  func JSONTaskWith(request: URLRequest, completionHandler: @escaping JSONCompletionHandler) -> JSONTask
    
}

extension APIManager {
  func JSONTaskWith(request: URLRequest, completionHandler: @escaping JSONCompletionHandler) -> JSONTask {
  
    let dataTask = session.dataTask(with: request) { (data, response, error) in
      
      guard let HTTPResponse = response as? HTTPURLResponse else {
        
        let userInfo = [
          NSLocalizedDescriptionKey: NSLocalizedString("Missing HTTP Response", comment: "")
        ]
        let error = NSError(domain: SWINetworkingErrorDomain, code: 100, userInfo: userInfo)
        
        completionHandler(nil, nil, error)
        return
      }
    
      if data == nil {
        if let error = error {
          completionHandler(nil, HTTPResponse, error)
        }
      } else {
        switch HTTPResponse.statusCode {
        case 200:
          do {
            let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: AnyObject]
            completionHandler(json, HTTPResponse, nil)
          } catch let error as NSError {
            completionHandler(nil, HTTPResponse, error)
          }
        default:
          print("We have got response status \(HTTPResponse.statusCode)")
        }
      }
    }
    return dataTask
  }
  
    func fetch<T>(request: URLRequest, parse: @escaping ([String: AnyObject]) -> [T]?, completionHandler: @escaping (APIResult<T>) -> Void) {
    
    let dataTask = JSONTaskWith(request: request) { (json, response, error) in
        DispatchQueue.main.async {
            guard let json = json else {
              if let error = error {
                completionHandler(.failure(error))
              }
              return
            }
            
            if let value = parse(json) {
              completionHandler(.success(value))
            } else {
              let error = NSError(domain: SWINetworkingErrorDomain, code: 200, userInfo: nil)
              completionHandler(.failure(error))
            }
        }
      
    }
    dataTask.resume()
  }
}

