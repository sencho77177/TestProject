//
//  GifVCCell.swift
//  TestProject
//
//  Created by Arsen Mkrtchyan on 15.05.22.
//

import UIKit
import Gifu

class GifVCCell: UICollectionViewCell {
    static var reuseId: String = "GifVCCell"
    let colors: [UIColor] = [
        .red, .blue, .orange, .brown, .systemPink
    ]
    
    
    var giphyImageView: GIFImageView = {
       let imageView = GIFImageView()
       //imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        giphyImageView.frame = self.frame
        giphyImageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        giphyImageView.backgroundColor = colors.randomElement()
        self.addSubview(giphyImageView)
       
       
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        giphyImageView.frame = self.bounds
    }
    
    func configure(whit value: Giphy) {
        guard let url = value.url else { return }
        guard let urlGif = URL(string: url) else { return }
       
        giphyImageView.animate(withGIFURL: urlGif)
        let height = Double(value.height ?? "200")
        let width = Double(value.width ?? "100")
        giphyImageView.frame = CGRect(x: 20.0, y: 390.0, width: width!,height: height!)
        
        //userImageView.sd_setImage(with: url, completed: nil)
    }
    
}
