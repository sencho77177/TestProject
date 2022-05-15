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
    var collectionView: UICollectionView!
    var giphys = [Giphy]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
            self.giphyManeger.openGiphy { result in
                switch result {
                    case .success(let gifs):
                    self.giphys = gifs
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        setupCollectionView()
        customizeSegmentControl()
        
        navigationController?.navigationBar.addSubview(segmentControl)
       // view.backgroundColor = .red
        
        
    }
    
    
    
    private func customizeSegmentControl() {
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
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        collectionView.backgroundColor = .orange
        view.addSubview(collectionView)
        collectionView.register(GifVCCell.self, forCellWithReuseIdentifier: GifVCCell.reuseId)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GifVCCell.reuseId, for: indexPath) as! GifVCCell
        cell.giphyImageView.image = #imageLiteral(resourceName: "human1")
        cell.backgroundColor = .red
        return cell
    }

}




extension HomeViewController {
    
   private func createLayout() -> UICollectionViewCompositionalLayout {
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2),
                                            heightDimension: .fractionalHeight(1))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
   // item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
       
    let verticalItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.5))
       
    let verticalStackItem = NSCollectionLayoutItem(layoutSize: verticalItemSize)
       
    //verticalStackItem.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
       
    let verticalGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalHeight(1))
       
    let verticalStackGroup = NSCollectionLayoutGroup.vertical(layoutSize: verticalGroupSize, subitem: verticalStackItem, count: 2)
       
    let tripletItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension:.fractionalWidth(1),
                                                                                heightDimension: .fractionalWidth(1)))
       
    let tripletHorizontalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(
        widthDimension:.fractionalWidth(1.0),
        heightDimension: .fractionalWidth(0.3)),
                                                                                subitem: tripletItem, count: 3)
       
    let horizontalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(
                                                                                            widthDimension: .fractionalWidth(1.0),
                                                                                            heightDimension:.fractionalWidth(0.7)),
                                                                                            subitems: [
                                                                                                        item,
                                                                                                        verticalStackGroup])
       
       let verticalGroup = NSCollectionLayoutGroup.vertical(layoutSize:NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),                                                                                              heightDimension: .fractionalHeight(1.0)),
                                                                                           subitems: [
                                                                                            horizontalGroup,
                                                                                            tripletHorizontalGroup
                                                                                            ])
    let section = NSCollectionLayoutSection(group: verticalGroup)
    
        return UICollectionViewCompositionalLayout(section: section)
    }
    private func aue() {
        
    }
}


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

