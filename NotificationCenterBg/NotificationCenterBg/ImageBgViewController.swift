//
//  BaseViewController.swift
//  asd
//
//  Created by 1 on 21.12.2022.
//

import UIKit

class ImageBgViewController: UIViewController {
    
    let imageView: UIImageView = .init(image: UIImage(named: ImageBgManager.shared.currentBg))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
        imageView.fillSuperView()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(changeBG),
            name: .changeName,
            object: nil)
    }
    
    @objc func changeBG(_ notification: NSNotification) {
        guard let name = notification.object as? String else {
            print("oops, got a non string from notificationCenter")
            return
        }
        
        let image = UIImage(named: name)
        self.imageView.image = image
    }
    
}
