//
//  Giphy.swift
//  TestProject
//
//  Created by Arsen Mkrtchyan on 14.05.22.
//

import Foundation


struct Giphy: Decodable {
    
    let url: String?
    let width: String?
    let height: String?
    
}
// petka poxel int stringov
extension Giphy: JSONDecodable {
    init?(JSON: [String : AnyObject]) {
        guard let url = JSON["url"] as? String,
              let width = JSON["width"] as? String,
              let height = JSON["height"] as? String else { return  nil }
        
        self.url = url
        self.width = width
        self.height = height
         
    }
}
