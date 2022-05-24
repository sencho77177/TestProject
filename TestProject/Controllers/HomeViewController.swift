//
//  HomeViewController.swift
//  TestProject
//
//  Created by Arsen Mkrtchyan on 13.05.22.
//

import UIKit
import CHTCollectionViewWaterfallLayout


class HomeViewController: UIViewController {
    let segmentControl = UISegmentedControl(first: "Trending", second: "Artist", third: "Clips", fourth: "Stories",fifth:"Sticker")
    var giphyManeger = APIGiphyManeger(apiKay: "W3ZBJcFdEhJnd23U0VEza1QYnAfAOjqE")
    var collectionView: UICollectionView!
    var giphys = [Giphy]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
            self.giphyManeger.loadGiphy { result in
                switch result {
                    case .success(let gifs):
                    self.giphys = gifs
                    self.collectionView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
        setupCollectionView()
        customizeSegmentControl()
        navigationController?.navigationBar.addSubview(segmentControl)
    }
    
  private func customizeSegmentControl() {
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentControl)
        NSLayoutConstraint.activate([
            segmentControl.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            segmentControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 1),
            segmentControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -1),
            segmentControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            segmentControl.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setupCollectionView() {
        let layout = CHTCollectionViewWaterfallLayout()
        layout.itemRenderDirection = .leftToRight
        layout.columnCount = 2
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        collectionView.backgroundColor = .black
        view.addSubview(collectionView)
        collectionView.register(GifVCCell.self, forCellWithReuseIdentifier: GifVCCell.reuseId)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, CHTCollectionViewDelegateWaterfallLayout {
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = Int(giphys[indexPath.row].width ?? "200")!
        let height = Int(giphys[indexPath.row].height ?? "300")!
        return CGSize(width: width, height: height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      
       return giphys.count
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GifVCCell.reuseId, for: indexPath) as! GifVCCell
            cell.configure(whit: giphys[indexPath.row])
            return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       let gif = giphys[indexPath.row]
        let profileVC = ShareScreenVC(value: gif)
        profileVC.modalPresentationStyle = .fullScreen
        present(profileVC, animated: true, completion: nil)
    }

}




extension HomeViewController {
    
   private func createLayout() -> UICollectionViewCompositionalLayout {
       
       let sItem1 = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1)))
       sItem1.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
       let sItem2 = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1)))
       sItem2.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
       let hGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.5))
       let hGroup = NSCollectionLayoutGroup.horizontal(layoutSize: hGroupSize, subitems: [sItem1, sItem2])
       let mItem = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.5)))
       mItem.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
       let vGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
       let vGroup = NSCollectionLayoutGroup.vertical(layoutSize: vGroupSize, subitems: [mItem, hGroup])
       vGroup.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
       let lItem = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1)))
       lItem.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
       let mainHGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1))
       let mainHGroup = NSCollectionLayoutGroup.horizontal(layoutSize: mainHGroupSize, subitems: [lItem, vGroup])
       let section = NSCollectionLayoutSection(group: mainHGroup)
    
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

