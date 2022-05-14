//
//  Data.swift
//  TestProject
//
//  Created by Arsen Mkrtchyan on 14.05.22.
//

import Foundation

struct Data {
    let data : [String: [AnyObject]]
  
}

extension Data: JSONDecodable {
    init?(JSON: [String : AnyObject]) {
        guard let data = JSON["data"] as? [String: [AnyObject]] else { return nil }
        self.data = data
    }
}
