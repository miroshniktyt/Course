//
//  BaseViewController.swift
//  ReactionRate
//
//  Created by 1 on 21.12.2022.
//

import UIKit

class BaseViewController: UIViewController {
    let imageView: UIImageView = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(imageView)
        imageView.fillSuperView()
        imageView.image = UIImage(named: "bg")
    }
}
