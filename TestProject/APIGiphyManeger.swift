//
//  APIGiphyManeger.swift
//  TestProject
//
//  Created by Arsen Mkrtchyan on 14.05.22.
//

import Foundation


enum ForecastType: FinalURLPoint {
   
  case Search(apiKey: String, searchText: String)
    
  var baseURL: URL {
    return URL(string: "api.giphy.com/v1/gifs/trending")!
  }
  
  var path: String {
      return "/?api_key=W3ZBJcFdEhJnd23U0VEza1QYnAfAOjqE)"
  }
  var searchURL: String {
      switch self {
      case .Search(let apiKey, let searchText):
        return "api.giphy.com/v1/gifs/search/?api_key=\(apiKey)&q=\(searchText)"
      }
    }
  
  static var request: URLRequest {
      URLRequest(url: URL(string: "https://api.giphy.com/v1/gifs/trending?api_key=W3ZBJcFdEhJnd23U0VEza1QYnAfAOjqE&limit=60")!)
  }
    var searchRequest: URLRequest {
      let url = URL(string: path, relativeTo: URL(string: searchURL))
      return URLRequest(url: url!)
    }
}

final class APIGiphyManeger: APIManager {
   
    
   let errorUrl = "https://media1.giphy.com/media/awxp4Wml8J4QoEPh3F/giphy-downsized.gif?cid=0666eb98oud2zk8kgu5h3yxnfbsw37rp6rcn444g0j5lxx9o&rid=giphy-downsized.gif&ct=g"
    let apiKey: String
    let sessionConfiguration: URLSessionConfiguration
    lazy var  session: URLSession = {
        return URLSession(configuration: self.sessionConfiguration)
    }()
    
    init(sessionConfiguration:URLSessionConfiguration, apiKey: String) {
        self.sessionConfiguration = sessionConfiguration
        self.apiKey = apiKey
    }
    
    convenience init(apiKay: String){
        self.init(sessionConfiguration: URLSessionConfiguration.default, apiKey: apiKay)
    }
    func searchGiphy(searchText: String, completionHandler: (APIResult<[Giphy]>) -> Void) {
        let _ = ForecastType.Search(apiKey: self.apiKey, searchText: searchText).searchRequest
    }
    
    
    
    func loadGiphy(completionHandler:@escaping (APIResult<Giphy>) -> Void) {
//        let request = ForecastType.Search(apiKey: self.apiKey, searchText: "searchText").request
        
        fetch(request: ForecastType.request,parse: { (json) -> [Giphy]? in
            var giphys = [Giphy]()
            if let dictionary = json["data"] as? [AnyObject] {
                for datas in dictionary {
                    if let imagesJSON = datas["images"] as? [String: AnyObject],
                        let downsizedJSON = imagesJSON["downsized"] as? [String: AnyObject]{
                        giphys.append(Giphy(JSON: downsizedJSON) ?? Giphy.init(url: self.errorUrl, width: "200", height: "250"))
                    } else {
                        return nil
                    }
                }
                return giphys
            } else {
                return nil
            }
        }, completionHandler: completionHandler)

    }
    
}
