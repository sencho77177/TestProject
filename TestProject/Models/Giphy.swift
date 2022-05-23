//
//  Giphy.swift
//  TestProject
//
//  Created by Arsen Mkrtchyan on 14.05.22.
//

import Foundation


struct Giphy: Decodable {
    
    let url: String?
    let width: Int?
    let height: Int?
    
}

extension Giphy: JSONDecodable {
    init?(JSON: [String : AnyObject]) {
        guard let url = JSON["url"] as? String,
              let width = JSON["width"] as? Int,
              let height = JSON["height"] as? Int else { return  nil }
        
        self.url = url
        self.width = width
        self.height = height
         
    }
}
