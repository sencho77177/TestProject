//
//  HomeCell.swift
//  TestProject
//
//  Created by Arsen Mkrtchyan on 15.05.22.
//

import UIKit

class HomeCell: UICollectionViewCell {
    static var reuseId: String = "gipyCell"
    
    var giphyImageView: UIImageView {
       let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        giphyImageView.backgroundColor = .red
        contentView.addSubview(giphyImageView)
        contentView.clipsToBounds = true
        backgroundColor = .blue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure(whit value: Giphy) {
        guard let url = value.url else { return }
        guard let urlGif = URL(string: url) else { return }
        
        //userImageView.sd_setImage(with: url, completed: nil)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        giphyImageView.frame = contentView.bounds
    }
}

