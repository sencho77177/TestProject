//
//  MainTabBarController.swift
//  TestProject
//
//  Created by Arsen Mkrtchyan on 13.05.22.
//

import UIKit
import SwiftUI

class MainTabBarController: UITabBarController {
     
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let homeVC = HomeViewController()
        let searchVC = SearchViewController()
        let boldConfig = UIImage.SymbolConfiguration(weight:.medium)
        let homeImage = UIImage(systemName: "house",withConfiguration:boldConfig)
        let searchImage = UIImage(systemName: "magnifyingglass",withConfiguration:boldConfig)
        viewControllers = [ generateNavigationController(rootViewController: homeVC, title: "Home", image: homeImage!),
                            generateNavigationController(rootViewController: searchVC, title: "Search", image: searchImage!)

        ]

    }
    
    private func generateNavigationController(rootViewController:UIViewController,
                                              title: String,
                                              image:UIImage) -> UIViewController {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        tabBar.standardAppearance = appearance
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().barTintColor = .black
        tabBar.scrollEdgeAppearance = tabBar.standardAppearance
        tabBar.backgroundColor = .black
        tabBar.tintColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.toolbar.backgroundColor = .systemBlue
        navigationVC.tabBarItem.title = title
        navigationVC.tabBarItem.image = image
        navigationVC.navigationBar.tintColor = .black
        return navigationVC
    }
}
