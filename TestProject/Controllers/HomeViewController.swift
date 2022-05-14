//
//  HomeViewController.swift
//  TestProject
//
//  Created by Arsen Mkrtchyan on 13.05.22.
//

import UIKit

class HomeViewController: UIViewController {
    let segmentControl = UISegmentedControl(first: "Trending", second: "Artist", third: "Clips", fourth: "Stories",fifth:"Sticker")
    var giphyManeger = APIGiphyManeger(apiKay: "W3ZBJcFdEhJnd23U0VEza1QYnAfAOjqE")
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
            self.giphyManeger.openGiphy { result in
                switch result {
                    case .Success(let gifs):
                    for i in gifs {
                        print("gg")
                    }
                case .Failure(let error):
                    print(error.localizedDescription)
                }
            }
        customizeElements()
        view.addSubview(collectionView)
        collectionView.register(HomeCell.self, forCellWithReuseIdentifier: HomeCell.reuseId)
        collectionView.frame = view.bounds
        collectionView.backgroundColor = .red
        collectionView.dataSource = self
        
        navigationController?.navigationBar.addSubview(segmentControl)
       // view.backgroundColor = .red
        
        
    }
    
    
    
    private func customizeElements() {
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentControl)
        NSLayoutConstraint.activate([
            segmentControl.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            segmentControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 1),
            segmentControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -1),
            segmentControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
           // segmentControl.widthAnchor.constraint(equalToConstant: 50),
            segmentControl.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    private func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.register(HomeCell.self, forCellWithReuseIdentifier: HomeCell.reuseId)
        collectionView.frame = view.bounds
        collectionView.backgroundColor = .red
        collectionView.dataSource = self
    }
}


extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCell.reuseId, for: indexPath)
        return cell
    }
}
// MARK: - SwiftUI


import SwiftUI

struct HomeVCProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        let tabBarVC = MainTabBarController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<HomeVCProvider.ContainerView>) -> MainTabBarController {
            return tabBarVC
        }
        
        func updateUIViewController(_ uiViewController: HomeVCProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<HomeVCProvider.ContainerView>) {
            
        }
    }
}

