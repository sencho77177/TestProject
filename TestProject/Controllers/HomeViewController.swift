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
                    case .Success(let gifs):
                    self.giphys = gifs
                case .Failure(let error):
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
        return 5
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
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalWidth(2/5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem:item, count: 2)
        
        let section = NSCollectionLayoutSection(group: group)
        //section.interGroupSpacing = 10
       // section.contentInsets = NSDirectionalEdgeInsets.init(top: 16, leading: 20, bottom: 0, trailing: 20)
        //let sectionHeader = createSectionHeader()
        
       // section.boundarySupplementaryItems = [sectionHeader]
        
        return UICollectionViewCompositionalLayout(section: section)
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

