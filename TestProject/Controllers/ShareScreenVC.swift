//
//  ShareScreenVC.swift
//  TestProject
//
//  Created by Arsen Mkrtchyan on 16.05.22.
//

import UIKit
import Gifu

class ShareScreenVC: UIViewController {
    
    let value: Giphy
    var gifImageView: GIFImageView = {
       let imageView = GIFImageView()
        imageView.backgroundColor = .systemPink
        return imageView
    }()
    lazy var copyLink: String =  {
        guard let url = value.url else { return "" }
        return url
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupElements()
        view.backgroundColor = .black
        addNavigationBar()
    }
    
    init(value: Giphy){
        self.value = value
        if let gifURL =  URL(string: value.url!)  {
            gifImageView.animate(withGIFURL: gifURL)
        }
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupElements() {
     
        gifImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(gifImageView)
        NSLayoutConstraint.activate([
            gifImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            gifImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gifImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            gifImageView.heightAnchor.constraint(equalToConstant: 400)
           
        ])
    }
    private func addNavigationBar() {
        let height: CGFloat = 40
        var statusBarHeight: CGFloat = 0
        statusBarHeight = view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 40
       let navbar = UINavigationBar(frame: CGRect(x: 0, y: statusBarHeight, width: UIScreen.main.bounds.width, height: height))
        navbar.delegate = self as? UINavigationBarDelegate
        let navItem = UINavigationItem()
        navItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action:#selector(dismissViewController))
        navItem.leftBarButtonItem?.image = UIImage(systemName: "xmark")
        navItem.leftBarButtonItem?.tintColor = .white
        navItem.rightBarButtonItem = UIBarButtonItem(title: "sh", style: .plain, target: self, action:#selector(presentAlert))
        navItem.rightBarButtonItem?.image = UIImage(systemName: "square.and.arrow.up")
        navItem.rightBarButtonItem?.tintColor = .white
        navbar.items = [navItem]
        view.addSubview(navbar)
    }
    
    @objc func dismissViewController() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @objc func presentAlert() {
        let alert = UIAlertController(title: "News",
                                      message: "New Sound was released by your favourite artist.",
                                      preferredStyle: .actionSheet)
        let copyGifAction = UIAlertAction(title: "Copy GIF Link",
                                         style: .default,
                                         handler: { _ in
            UIPasteboard.general.string = self.value.url
            print("Copy GIF Link")
            
            
        })
        alert.addAction(copyGifAction)
        
        alert.addAction(UIAlertAction(title: "Copy GIF",
                                      style: .default,
                                      handler: { _ in
            guard let image = self.gifImageView.image else { return }
            self.writeToPhotoAlbum(image:image)
           
            print("Copy Gif")
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel",
                                      style: .cancel,
                                      handler: nil))
        let subView = (alert.view.subviews.first?.subviews.first)! as UIView
        subView.backgroundColor = .black
        alert.view.tintColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        let imageSMS = UIImageView(frame: CGRect(x: 0, y: 0, width: 65, height: 65))
        let imageSnupChat = UIImageView(frame: CGRect(x: 68, y: 0, width: 65, height: 65))
        let imageWhatsApp = UIImageView(frame: CGRect(x: 134, y: 0, width: 65, height: 65))
        let imageInstagram = UIImageView(frame: CGRect(x: 201, y: 0, width: 65, height: 65))
        let imageFacebook = UIImageView(frame: CGRect(x: 268, y: 0, width: 65, height: 65))
        let imageTwiter = UIImageView(frame: CGRect(x: 335, y: 0, width: 65, height: 65))
        
        imageSMS.image = UIImage(named: "sms")
        imageSnupChat.image = UIImage(named: "snapchat")
        imageWhatsApp.image = UIImage(named: "whatsapp")
        imageInstagram.image = UIImage(named: "insagram")
        imageFacebook.image = UIImage(named: "facebook")
        imageTwiter.image = UIImage(named: "tvich")
        
        alert.view.addSubview(imageSMS)
        alert.view.addSubview(imageSnupChat)
        alert.view.addSubview(imageWhatsApp)
        alert.view.addSubview(imageInstagram)
        alert.view.addSubview(imageFacebook)
        alert.view.addSubview(imageTwiter)
        present(alert, animated: true, completion: nil)
    }
    
        
        func writeToPhotoAlbum(image: UIImage) {
                UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
            }

            @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
                print("Save finished!")
            }
}
