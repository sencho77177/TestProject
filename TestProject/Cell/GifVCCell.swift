//
//  GifVCCell.swift
//  TestProject
//
//  Created by Arsen Mkrtchyan on 15.05.22.
//

import UIKit

class GifVCCell: UICollectionViewCell {
    static var reuseId: String = "GifVCCell"
    
    var giphyImageView: UIImageView {
       let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(giphyImageView)
        giphyImageView.image = #imageLiteral(resourceName: "human1")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        giphyImageView.frame = contentView.bounds
    }
    
}
