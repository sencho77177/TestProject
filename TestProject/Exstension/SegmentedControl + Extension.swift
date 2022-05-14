//
//  SegmentedControl + Extension.swift
//  TestProject
//
//  Created by Arsen Mkrtchyan on 13.05.22.
//

import UIKit


extension UISegmentedControl {
    
    convenience init(first: String, second: String,third: String,fourth: String, fifth: String) {
        self.init()
        self.insertSegment(withTitle: first, at: 0, animated: true )
        self.insertSegment(withTitle: second, at: 1, animated: true )
        self.insertSegment(withTitle: third, at: 2, animated: true )
        self.insertSegment(withTitle: fourth, at: 3, animated: true )
        self.insertSegment(withTitle: fifth, at: 4, animated: true )
        self.selectedSegmentIndex = 0
        self.selectedSegmentTintColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        self.layer.cornerRadius = self.bounds.height / 2
        self.layer.borderWidth = 1
        self.layer.masksToBounds = true
        let font = UIFont.systemFont(ofSize: 18)
        self.setTitleTextAttributes([NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        
    }
}

