//
//  SmartImageView.swift
//  NotificationCenterBg
//
//  Created by 1 on 23.12.2022.
//

import UIKit

class SmartImageView: UIImageView {
    override func didMoveToSuperview() {
        
        changeTint()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(changeTint),
            name: .changeName,
            object: nil)
    }
    
    @objc func changeTint() {
        let bg = ImageBgManager.shared.currentBg
        let isWarm = bg == "bg2"
//        if isWarm {
//            self.tintColor = .blue
//        } else {
//            self.tintColor = .orange
//        }
        self.tintColor = isWarm ? .blue : .orange // turnary operator take a look
    }
}
