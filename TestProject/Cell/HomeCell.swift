//
//  HomeCell.swift
//  TestProject
//
//  Created by Arsen Mkrtchyan on 15.05.22.
//

import UIKit

class HomeCell: UICollectionViewCell {
    static var reuseId: String = "GipyCell"
    let colors: [UIColor] = [
        .red, .blue, .orange, .brown, .systemPink
    ]
    var giphyImageView: UIImageView {
       let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        giphyImageView.backgroundColor = colors.randomElement()!
        addSubview(giphyImageView)
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure(whit value: Giphy) {
        guard let url = value.url else { return }
        guard let urlGif = URL(string: url) else { return }
        //let imageURL = UIImage.gifImageWithURL(urlGif)
        //let giphyImageView = UIImageView(image: imageURL)
        let height = Double(value.height ?? "200")
        let width = Double(value.width ?? "100")
        giphyImageView.frame = CGRect(x: 20.0, y: 390.0, width: width!,height: height!)
        
        //userImageView.sd_setImage(with: url, completed: nil)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        giphyImageView.frame = contentView.bounds
    }
}
